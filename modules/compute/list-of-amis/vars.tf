variable "region" {
    type = "string"
    description = "The AWS region to deploy into (e.g. us-east-1)"
}

variable "aws_access_key" {
    type = "string"
    description = "ID of the API key to use"
}

variable "aws_secret_key" {
    type = "string"
    description = "Secret value of the API key to use"
}

variable "vpc_bucket" {
    type = "string"
    description = "S3 bucket containing the VPC Terraform state"
}

variable "vpc_key" {
    type = "string"
    description = "S3 key pointing to the VPC Terraform state"
}

variable "vpc_region" {
    type = "string"
    description = "Region where the S3 bucket containing the VPC Terraform state is located"
}

variable "security_groups_bucket" {
    type = "string"
    description = "S3 bucket containing the security groups Terraform state"
}

variable "security_groups_key" {
    type = "string"
    description = "S3 key pointing to the security groups Terraform state"
}

variable "security_groups_region" {
    type = "string"
    description = "Region where the S3 bucket containing the security groups Terraform state is located"
}

variable "project" {
    type = "string"
    description = "Name of the project these resources are being created for"
}

variable "creator" {
    type = "string"
    description = "Person creating these resources"
}

variable "environment" {
    type = "string"
    description = "Context these resources will be used in, e.g. production"
}

variable "freetext" {
    type = "string"
    description = "Information that does not fit in the other tags"
}

variable "instance_type" {
    type = "string"
    description = "Instance type to make the Bastion host from"
}

variable "ssh_key_name" {
    type = "string"
    description = "Name of the SSH key pair to use when logging into the bastion host"
}

variable "ami_list" {
    type = "list"
    description = "List of AMIs to spin up"
}

variable "instance_names" {
    type = "list"
    description = "What to name each instance"
}

variable "volume_size" {
    type = "string"
    description = "How large to make the EBS volume, in GB"
}
