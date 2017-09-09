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

variable "name" {
    type = "string"
    description = "Name of the resource"
}

variable "project" {
    type = "string"
    description = "Name of the project these resources are being created for"
}

variable "purpose" {
    type = "string"
    description = "Role or reason for the existence of these resources"
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

variable "bastion_ingress_cidr_blocks" {
    type = "list"
    description = "IP ranges to allows inbound SSH access to"
}
