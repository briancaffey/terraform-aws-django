#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status.

# Ensure all packages are up-to-date
sudo yum update -y

# Mount data volume
DEVICE=$(lsblk -rpo "NAME,MOUNTPOINT" | awk '$2==""{print $1}' | head -1)
if [ ! -z "$DEVICE" ] && [ ! -d /data ]; then
  if ! blkid $DEVICE; then
    sudo mkfs -t ext4 $DEVICE
  fi
  sudo mkdir -p /data
  sudo mount $DEVICE /data
  echo "$DEVICE /data ext4 defaults,nofail 0 2" | sudo tee -a /etc/fstab
fi

# Install Docker and start service
sudo yum install -y docker
sudo systemctl enable docker
sudo systemctl start docker

# Add ssm-user to docker group
sudo usermod -aG docker ssm-user

# Fix permissions so ssm-user can access Docker socket
sudo chmod 666 /var/run/docker.sock

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/${docker_compose_version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Ensure ssm-user can run docker without sudo
echo "ssm-user ALL=(ALL) NOPASSWD: /usr/bin/docker, /usr/local/bin/docker-compose" | sudo tee /etc/sudoers.d/ssm-user-docker

# Clone repository
APP_DIR="/opt/django-step-by-step"
if [ ! -d "$APP_DIR" ]; then
  sudo yum install -y git
  sudo git clone ${git_repo} $APP_DIR
fi

# Checkout specified Git reference
cd $APP_DIR
sudo git fetch
sudo git checkout ${git_tag}
sudo git pull origin ${git_tag}

# Create necessary directories
sudo mkdir -p /data/postgres /data/redis /data/etcd

# Configure systemd service for Docker Compose
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

# Reload systemd, enable, and start the service
sudo systemctl daemon-reload
sudo systemctl enable django-app.service
sudo systemctl start django-app.service

# Reboot to apply group membership changes without manual intervention
sudo reboot
