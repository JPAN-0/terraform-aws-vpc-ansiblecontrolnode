variable "namespace" {
  type = string
}

variable "vpc" {
  type = any
}

variable key_name {
  type = string
}

variable "sg_pub_id" {
  type = any
}

variable "sg_priv_id" {
  type = any
}

variable "aws_ami_type" {
  type = string
  description = "aws EC2 instance ami"
}

variable "aws_instance_type" {
  type = string
  description = "aws EC2 instance type"
}

variable "enviornment_tag" {
  type = string
  description = "Enviornment tag"
}

variable "instance_name" {
  type = string
  description = "Instance Name" 
}