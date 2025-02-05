#cloud-config
# Install required packages
packages:
  - docker-ce
  - docker-ce-cli
  - containerd.io
  - docker-buildx-plugin
  - docker-compose-plugin
  - ca-certificates
  - curl
  - gnupg



runcmd:
  - apt-get update -y
  - apt-get install -y ca-certificates curl gnupg
  - install -m 0755 -d /etc/apt/keyrings
  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  - chmod a+r /etc/apt/keyrings/docker.gpg
  - echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
  - apt-get update -y
  - apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin git
  - systemctl enable docker
  - systemctl start docker
  - usermod -aG docker ubuntu
  - echo "Git tag is... ${git_tag}"
  - echo "Running docker ps to check docker availability"
  - docker ps