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

variable "cidr_range" {
    type = "string"
    description = "IP range of the network to create"
    default = "10.0.0.0/16"
}

variable "name" {
    type = "string"
    description = "Name of the VPC"
    default = "Experiment"
}

variable "project" {
    type = "string"
    description = "Name of the project this VPC is being created for"
    default = "Weapon-X"
}

variable "purpose" {
    type = "string"
    description = "Role or reason for the existence of the VPC"
    default = "Separate network for experimentation"
}

variable "creator" {
    type = "string"
    description = "Person creating the VPC"
    default = "nobody@example.com"
}

variable "environment" {
    type = "string"
    description = "Context the VPC will be used in, e.g. production"
    default = "development"
}

variable "freetext" {
    type = "string"
    description = "Information that does not fit in the other tags"
    default = "No notes at this time"
}

variable "public_subnets" {
    description = "List of public subnets"
    type        = "list"
    default     = ["10.0.2.0/24", "10.0.4.0/24", "10.0.6.0/24", "10.0.8.0/24", "10.0.10.0/24", , "10.0.12.0/24", , "10.0.14.0/24"]
}

variable "private_subnets" {
    description = "List of private subnets"
    type        = "list"
    default     = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24", "10.0.7.0/24", , "10.0.9.0/24", "10.0.11.0/24", , "10.0.13.0/24"]
}
