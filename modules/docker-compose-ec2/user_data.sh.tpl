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
APP_DIR="/opt/django-step-by-step"

# Install Git if needed
sudo apt-get install -y git

if [ ! -d "$APP_DIR" ]; then
  sudo git clone "${git_repo}" "$APP_DIR"
fi

cd "$APP_DIR"
sudo git fetch --all
sudo git checkout "${git_tag}"
sudo git pull origin "${git_tag}" || true

######################################
# 4. Create directories for persistent data
######################################
sudo mkdir -p /data/postgres /data/redis /data/etcd

######################################
# 5. Create a systemd service to run Docker Compose
######################################
cat <<EOF | sudo tee /etc/systemd/system/django-app.service
[Unit]
Description=Django Application
Requires=docker.service
After=docker.service

[Service]
Restart=always
WorkingDirectory=$APP_DIR
ExecStart=/usr/local/bin/docker-compose up -d
ExecStop=/usr/local/bin/docker-compose down

[Install]
WantedBy=multi-user.target
EOF

# Enable and start the systemd service
sudo systemctl daemon-reload
sudo systemctl enable django-app.service
sudo systemctl start django-app.service

echo "Rebooting the instance to finalize group membership changes..."
sleep 2
sudo reboot