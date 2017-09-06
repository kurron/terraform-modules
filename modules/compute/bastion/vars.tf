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

variable "name" {
    type = "string"
    description = "Name of the instance"
    default = "Experiment"
}

variable "vpc_bucket" {
    type = "string"
    description = "S3 bucket containing the VPC Terraform state"
    default = "transparent-terraform-state"
}

variable "vpc_key" {
    type = "string"
    description = "S3 key pointing to the VPC Terraform state"
    default = "development/networking/vpc/terraform.tfstate"
}

variable "vpc_region" {
    type = "string"
    description = "Region where the S3 bucket containing the VPC Terraform state is located"
    default = "us-east-1"
}

variable "project" {
    type = "string"
    description = "Name of the project this instance is being created for"
    default = "Weapon-X"
}

variable "purpose" {
    type = "string"
    description = "Role or reason for the existence of the instance"
    default = "Controls SSH access to instances within the VPC"
}

variable "creator" {
    type = "string"
    description = "Person creating the instance"
    default = "nobody@example.com"
}

variable "environment" {
    type = "string"
    description = "Context the instance will be used in, e.g. production"
    default = "development"
}

variable "freetext" {
    type = "string"
    description = "Information that does not fit in the other tags"
    default = "No notes at this time"
}

variable "instance_type" {
    type = "string"
    description = "Instance type to make the Bastion host from"
    default = "t2.nano"
}

variable "ssh_key_name" {
    type = "string"
    description = "Name of the SSH key pair to use when logging into the bastion host"
}

variable "max_size" {
    type = "string"
    description = "Maximum number of bastion instances that can be run simultaneously"
    default = "2"
}

variable "min_size" {
    type = "string"
    description = "Minimum number of bastion instances that can be run simultaneously"
    default = "1"
}

variable "cooldown" {
    type = "string"
    description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start."
    default = "60"
}

variable "health_check_grace_period" {
    type = "string"
    description = "Time (in seconds) after instance comes into service before checking health."
    default = "300"
}

variable "desired_capacity" {
    type = "string"
    description = "The number of Amazon EC2 instances that should be running in the group."
    default = "1"
}

variable "scale_down_desired_capacity" {
    type = "string"
    description = "The number of Amazon EC2 instances that should be running when scaling down."
    default = "0"
}

variable "scaled_down_min_size" {
    type = "string"
    description = "Minimum number of bastion instances that can be running when scaling down"
    default = "0"
}

variable "ssh_ingress_cidr_blocks" {
    type = "list"
    description = "IP ranges to allows inbound SSH access to"
    default = ["98.216.147.13/32"]
}

variable "scale_up_cron" {
    type = "string"
    description = "In UTC, when to scale up the bastion servers"
    default = "0 12 * * *"
}

variable "scale_down_cron" {
    type = "string"
    description = "In UTC, when to scale down the bastion servers"
    default = "0 0 * * *"
}
