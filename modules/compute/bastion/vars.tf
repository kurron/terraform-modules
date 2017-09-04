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
