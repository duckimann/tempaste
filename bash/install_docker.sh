#/bin/bash

# Reference
# https://docs.docker.com/compose/install/
# https://docs.docker.com/engine/install/ubuntu/

# Tested on Ubuntu 20.04

# Update APT
sudo apt update -y;
sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release -y;

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg;

# Set up "stable" repo
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;

# Install Docker
sudo apt update -y;
sudo apt install docker-ce docker-ce-cli containerd.io -y;

# Download Docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose;
# Privileges docker compose
sudo chmod +x /usr/local/bin/docker-compose;

echo "Done.";