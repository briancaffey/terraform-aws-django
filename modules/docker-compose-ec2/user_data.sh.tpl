#!/bin/bash
set -e  # Exit immediately if any command exits with a non-zero status.

######################################
# 1. Install Docker and Docker Compose
######################################
# Add Docker’s official GPG key and repository for Ubuntu 24.04
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker’s apt repository (for stable releases)
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine, Docker CLI, and Docker Compose plugin
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add ssm-user to the docker group (so it can run Docker without sudo)
sudo usermod -aG docker ssm-user

######################################
# 2. Mount data volume (if attached)
######################################
DEVICE=$(lsblk -rpo "NAME,MOUNTPOINT" | awk '$2=="" {print $1}' | head -1)
if [ -n "$DEVICE" ] && [ ! -d /data ]; then
  if ! blkid "$DEVICE" > /dev/null 2>&1; then
    sudo mkfs -t ext4 "$DEVICE"
  fi
  sudo mkdir -p /data
  sudo mount "$DEVICE" /data
  echo "$DEVICE /data ext4 defaults,nofail 0 2" | sudo tee -a /etc/fstab
fi

######################################
# 3. Clone your repository and check out the desired tag
######################################
APP_DIR="/home/ssm-user"

# Install Git if needed
sudo apt-get install -y git

if [ ! -d "$APP_DIR" ]; then
  git clone "${git_repo}" "$APP_DIR"
fi

cd "$APP_DIR"
git fetch --all
git checkout "${git_tag}"
git pull origin "${git_tag}" || true

cd django-step-by-step
# docker compose commands to create the SSL certificate with certbot
docker compose -p app -f nginx/ec2/docker-compose.ec2.init.yml run --rm config-generator # generate nginx configs
docker compose -p app -f nginx/ec2/docker-compose.ec2.init.yml up -d nginx-init # start the http server
docker compose -p app -f nginx/ec2/docker-compose.ec2.init.yml run --rm certbot-init # generate certs with certbot
docker compose -p app -f nginx/ec2/docker-compose.ec2.init.yml down nginx-init # stop the http server

######################################
# 4. Create directories for persistent data
######################################
sudo mkdir -p /data/postgres /data/redis /data/etcd

######################################
# 5. Create a systemd service to run Docker Compose
######################################
cat <<EOF | sudo tee /etc/systemd/system/app.service
[Unit]
Description=Django Application
Requires=docker.service
After=docker.service

[Service]
Restart=always
WorkingDirectory=$APP_DIR/
ExecStart=/usr/bin/docker compose -p app -f /home/ssm-user/django-step-by-step/docker-compose.ec2.yml up -d
ExecStop=/usr/bin/docker compose -p app -f /home/ssm-user/django-step-by-step/docker-compose.ec2.yml down

[Install]
WantedBy=multi-user.target
EOF

# Enable and start the systemd service
sudo systemctl daemon-reload
sudo systemctl enable app.service
sudo systemctl start app.service

echo "Rebooting the instance to finalize group membership changes..."
sleep 2
sudo reboot
