#!/bin/bash

# Update and upgrade the system packages
apt-get update -y && apt-get upgrade -y

# --- Install Python ---
echo "Installing Python..."
apt-get install -y python3 python3-pip python3-venv

# --- Install Docker ---
echo "Installing Docker..."

# Install dependencies
apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | tee /etc/apt/trusted.gpg.d/docker.asc

# Set up the Docker stable repository
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# Update apt package index again
apt-get update -y

# Install Docker CE (Community Edition)
apt-get install -y docker-ce

# Enable Docker to start on boot and start Docker service
systemctl enable docker
systemctl start docker

# Allow user to run Docker commands without sudo (this requires a reboot to take effect)
usermod -aG docker ubuntu

# Verify Docker installation
docker --version

# --- Install Terraform ---
echo "Installing Terraform..."

# Download Terraform binary
TERRAFORM_VERSION="1.7.6"  # Change this version if you need a different one
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install unzip if it's not already installed
apt-get install -y unzip

# Unzip Terraform binary
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Move Terraform to a directory in PATH
mv terraform /usr/local/bin/

# Clean up Terraform zip file
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Verify Terraform installation
terraform --version

# --- Install Java (OpenJDK 11) ---
echo "Installing Java (OpenJDK 11)..."
apt-get install -y openjdk-11-jdk

# Verify Java installation
java -version

# --- Clean Up ---
echo "Cleaning up..."
apt-get autoremove -y
apt-get clean

echo "Installation complete!"
echo "Please reboot your system or log out and log back in for Docker user group changes to take effect."
