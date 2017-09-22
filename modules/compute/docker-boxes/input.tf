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

variable "bastion_bucket" {
    type = "string"
    description = "S3 bucket containing the Bastion Terraform state"
}

variable "bastion_key" {
    type = "string"
    description = "S3 key pointing to the Bastion Terraform state"
}

variable "bastion_region" {
    type = "string"
    description = "Region where the S3 bucket containing the Bastion Terraform state is located"
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

variable "ebs_optimized" {
    type = "string"
    description = " If true, the launched worker will be EBS-optimized."
}
