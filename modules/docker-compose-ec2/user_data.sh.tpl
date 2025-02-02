#!/bin/bash
set -e  # Exit immediately if any command exits with a non-zero status.

# ------------------------------
# Update system and mount volume
# ------------------------------
sudo yum update -y

# Mount data volume if present and not already mounted
DEVICE=$(lsblk -rpo "NAME,MOUNTPOINT" | awk '$2==""{print $1}' | head -1)
if [ -n "$DEVICE" ] && [ ! -d /data ]; then
  if ! blkid "$DEVICE"; then
    sudo mkfs -t ext4 "$DEVICE"
  fi
  sudo mkdir -p /data
  sudo mount "$DEVICE" /data
  echo "$DEVICE /data ext4 defaults,nofail 0 2" | sudo tee -a /etc/fstab
fi

# ------------------------------
# Install Docker (but DO NOT start it yet)
# ------------------------------
sudo yum install -y docker

# -------------------------------------------
# Create a systemd drop-in for docker.socket
# This will force the socket permissions to 0666.
# Place this override BEFORE docker is started.
# -------------------------------------------
sudo mkdir -p /etc/systemd/system/docker.socket.d
cat <<'EOF' | sudo tee /etc/systemd/system/docker.socket.d/10-override.conf
[Socket]
SocketMode=0666
EOF

# Reload systemd so it picks up the drop-in
sudo systemctl daemon-reload

# ------------------------------
# Now enable and start Docker
# ------------------------------
sudo systemctl enable docker
sudo systemctl start docker

# (Optional) Verify the Docker socket permissions
ls -l /var/run/docker.sock

# ------------------------------
# Add ssm-user to the docker group (good practice even though the socket is open)
# ------------------------------
sudo usermod -aG docker ssm-user

# ------------------------------
# Install Docker Compose
# ------------------------------
# (Ensure ${docker_compose_version} is set correctly)
sudo curl -L "https://github.com/docker/compose/releases/download/${docker_compose_version}/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Allow ssm-user to run docker and docker-compose without sudo (optional now)
echo "ssm-user ALL=(ALL) NOPASSWD: /usr/bin/docker, /usr/local/bin/docker-compose" \
  | sudo tee /etc/sudoers.d/ssm-user-docker

# ------------------------------
# Clone your repository and checkout the desired tag
# ------------------------------
APP_DIR="/opt/django-step-by-step"
if [ ! -d "$APP_DIR" ]; then
  sudo yum install -y git
  sudo git clone ${git_repo} "$APP_DIR"
fi

cd "$APP_DIR"
sudo git fetch
sudo git checkout ${git_tag}
sudo git pull origin ${git_tag}

# ------------------------------
# Create necessary directories for data
# ------------------------------
sudo mkdir -p /data/postgres /data/redis /data/etcd

# ------------------------------
# Create a systemd service for your Docker Compose-based app
# ------------------------------
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

sudo systemctl daemon-reload
sudo systemctl enable django-app.service
sudo systemctl start django-app.service

# ------------------------------
# (No reboot is necessary now)
# ------------------------------
