#!/bin/bash
set -e  # Exit immediately if any command exits with a non-zero status.

apt-get update -y
apt-get install -y ca-certificates curl gnupg

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y
apt-get install -y \
  docker-ce docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

usermod -aG docker ubuntu

######################################
# 2. Mount data volume (if attached)
######################################
# echo "Mounting volumes"
# # SUDO: mkfs, mkdir, mount, tee
# DEVICE=$(lsblk -rpo "NAME,MOUNTPOINT" | awk '$2=="" {print $1}' | head -1)
# # Proceed only if a device is found
# if [ -n "$DEVICE" ]; then
#   # Create /data if it doesn't exist
#   mkdir -p /data

#   # Only mount if /data is not already a mountpoint
#   if ! mountpoint -q /data; then
#     # If the device does not have a filesystem, create one
#     if ! blkid "$DEVICE" > /dev/null 2>&1; then
#       mkfs -t ext4 "$DEVICE"
#     fi
#     mount "$DEVICE" /data
#     echo "$DEVICE /data ext4 defaults,nofail 0 2" | tee -a /etc/fstab
#   else
#     echo "/data is already mounted, skipping mount."
#   fi
# else
#   echo "No available device found for mounting."
# fi

######################################
# 3. Clone your repository and check out the desired tag
######################################
# echo "Clone git repository"
# APP_DIR="/home/ubuntu"

# Install Git if needed
# SUDO:
apt-get install -y git

# if [ ! -d "$APP_DIR" ]; then
#   git clone "${git_repo}" "$APP_DIR"
# fi

# cd "$APP_DIR"
# git fetch --all
# git checkout "${git_tag}"
# git pull origin "${git_tag}" || true

# cd django-step-by-step
# docker compose commands to create the SSL certificate with certbot
# do I need to run these commands as sudo?
# SUDO:
# docker compose -p app -f nginx/ec2/docker-compose.ec2.init.yml run --rm -e DOMAIN_NAME=${domain_name} config-generator # generate nginx configs
# docker compose -p app -f nginx/ec2/docker-compose.ec2.init.yml up -d nginx-init # start the http server
# docker compose -p app -f nginx/ec2/docker-compose.ec2.init.yml run --rm certbot-init # generate certs with certbot
# docker compose -p app -f nginx/ec2/docker-compose.ec2.init.yml down # stop the http server

######################################
# 4. Create directories for persistent data
######################################
# SUDO:
# mkdir -p /data/postgres /data/redis /data/etcd

######################################
# 5. Create a systemd service to run Docker Compose
######################################
# SUDO:
# cat <<EOF | tee /etc/systemd/system/app.service
# [Unit]
# Description=Django Application
# Requires=docker.service
# After=docker.service

# [Service]
# Restart=always
# WorkingDirectory=/home/ubuntu/django-step-by-step
# ExecStart=/usr/bin/docker compose -p app -f /home/ubuntu/django-step-by-step/docker-compose.ec2.yml up -d
# ExecStop=/usr/bin/docker compose -p app -f /home/ubuntu/django-step-by-step/docker-compose.ec2.yml down

# [Install]
# WantedBy=multi-user.target
# EOF

# # Enable and start the systemd service
# systemctl daemon-reload
# systemctl enable app.service
# systemctl start app.service
