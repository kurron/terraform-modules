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

variable "cluster_name" {
    type = "string"
    description = "The name of the cluster (up to 255 letters, numbers, hyphens, and underscores) "
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

variable "iam_bucket" {
    type = "string"
    description = "S3 bucket containing the IAM Terraform state"
}

variable "iam_key" {
    type = "string"
    description = "S3 key pointing to the IAM Terraform state"
}

variable "iam_region" {
    type = "string"
    description = "Region where the S3 bucket containing the IAM Terraform state is located"
}

variable "project" {
    type = "string"
    description = "Name of the project these resources are being created for"
}

variable "creator" {
    type = "string"
    description = "Person creating the resources"
}

variable "environment" {
    type = "string"
    description = "Context the resources will be used in, e.g. production"
}

variable "freetext" {
    type = "string"
    description = "Information that does not fit in the other tags"
}

variable "instance_type" {
    type = "string"
    description = "Instance type to make the worker hosts from"
}

variable "ssh_key_name" {
    type = "string"
    description = "Name of the SSH key pair to use when logging into the worker hosts"
}

variable "spot_max_size" {
    type = "string"
    description = "Maximum number of worker instances that can be run simultaneously"
}

variable "spot_min_size" {
    type = "string"
    description = "Minimum number of work instances that can be run simultaneously"
}

variable "cooldown" {
    type = "string"
    description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start."
}

variable "health_check_grace_period" {
    type = "string"
    description = "Time, in seconds, after instance comes into service before checking health."
}

variable "spot_desired_capacity" {
    type = "string"
    description = "The number of workers that should be running in the group."
}

variable "spot_scale_down_desired_capacity" {
    type = "string"
    description = "The number of workers that should be running when scaling down."
}

variable "spot_scale_down_min_size" {
    type = "string"
    description = "Minimum number of workers that can be running when scaling down"
}

variable "spot_scale_up_cron" {
    type = "string"
    description = "In UTC, when to scale up the worker instances"
}

variable "spot_scale_down_cron" {
    type = "string"
    description = "In UTC, when to scale down the worker instances"
}

variable "spot_price" {
    type = "string"
    description = "The cost per hour you are willing to pay for a spot instance."
}

variable "ebs_optimized" {
    type = "string"
    description = " If true, the launched worker will be EBS-optimized."
}
