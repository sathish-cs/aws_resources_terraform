# Terraform Remote Exec Provisioner Setup

This Terraform configuration demonstrates how to use the **Remote Exec Provisioner** to run commands on a remote server after it has been created. 

## What is Remote Exec Provisioner?

The `remote-exec` provisioner allows you to execute commands on a remote machine after it has been created, using an SSH connection. This is commonly used to install packages, configure settings, or initiate scripts automatically after instance provisioning.

## Resources

This repository includes the following resources:

- **aws_instance**: A AWS EC2 instance created by Terraform.
- **remote-exec provisioner**: Runs script on the instance to install packages after EC2 instance creation.
