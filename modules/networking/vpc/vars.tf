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
    description = "Name of the VPC"
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

variable "cidr_range" {
    type = "string"
    description = "IP range of the network to create"
}

variable "public_subnets" {
    description = "List of public subnets"
    type        = "list"
}

variable "private_subnets" {
    description = "List of private subnets"
    type        = "list"
}
