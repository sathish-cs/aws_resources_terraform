#!/bin/bash

# Update the package list
sudo apt-get update -y

# Install required dependencies
sudo apt-get install -y unzip curl

# Download the AWS CLI v2 installation package
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip the package
unzip awscliv2.zip

# Install AWS CLI v2
sudo ./aws/install

# Verify AWS CLI installation
if aws --version; then
    echo "AWS CLI installed successfully."
else
    echo "AWS CLI installation failed." >&2
    exit 1
fi

# Install Git and NGINX
sudo apt-get install -y git nginx

# Start and enable NGINX service
sudo systemctl start nginx
sudo systemctl enable nginx

# Verify NGINX installation
if systemctl is-active --quiet nginx; then
    echo "NGINX installed and running successfully."
else
    echo "NGINX installation or startup failed." >&2
    exit 1
fi
