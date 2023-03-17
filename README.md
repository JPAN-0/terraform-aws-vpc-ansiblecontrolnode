# Based on: https://github.com/bugbiteme/demo-tform-aws-vpc

## ToDo

If this is going to be used in the future for management of estate, and the Ansible host will be used as the Ansible control node, then further planning is needed.

This leaves Ansible control node vulnerable as it is open on public internet with SSH open. Need to plan how to further secure control node.

# AWS VPC Creation with Terraform
This project will create a VCP with Internet Gateway, subnets accross 2 AZs: one public
and one one private.

From there terraform will deploy a bastian host and an Ansible control node in the public subnet in AZ1 and a second host
in the private subnet in AZ2, which can connect to the internet via a NAT gateway created
as part of the VPC. 

The number of instances/hosts is based on the count meta-argument set in the main.tf file.

An SSH key pair is dynamically generated as well, and the private key is copied over to the
bastian host.

The ec2 instance in the public subnet is assigned a security group with access from the 
the intenret via port 22 (for ssh).

The ec2 instance in the private subnet is assigned to a security group that only allows
ssh access only from connections in the public subnet.

The ansible control node instance is assigned to the same groups as the ec2 private instance. It is meant to act as the Ansible control node and is used to configure the private instances via Ansible. 

Both security groups are dynamically created in the network module.

## Current state

Modules:

- ssh-key: Generates an ssh key pair
- network: Sets up a VPC with IGWs, NAT GWs, 2 public subnets, 2 private subnets, SG to SSH in from anywhere
- ec2: Currently creates a bastian ec2 instance in a public subnet and a ec2 instance in a private subnet
- each subnet is in a different AZ
- private key is copied over to the bastion ec2 instance so it can ssh into the private subnet
- ec2 in private subnet has outgoing network access though the NAT gateway
- ec2_ansible: Creates another EC2 instance in the public network that has Ansible installed via Terraform's remote-exec. This creates an Ansible control node that can SSH into nodes on the private subnet to configure.

## Requirements

No requirements.

## Providers

S3

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| namespace | The project namespace to use for unique resource naming | `string` | `"Terraform-Test"` | no |
| region | AWS region | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| private\_connection\_string | Copy/Paste/Enter - You are in the private ec2 instance |
| public\_connection\_string | Copy/Paste/Enter - You are in the public ec2 instance |

