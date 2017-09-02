variable "region" {
    description = "The AWS region to deploy into (e.g. us-east-1)"
}

variable "aws_access_key" {
    description = "ID of the API key to use"
}

variable "aws_secret_key" {
    description = "Secret value of the API key to use"
}

variable "cidr_range" {
    description = "IP range of the network to create"
    default = "10.0.0.0/16"
}

variable "name" {
    description = "Name of the VPC"
    default = "Experiment"
}

variable "project" {
    description = "Name of the project this VPC is being created for"
    default = "Weapon-X"
}

variable "purpose" {
    description = "Role or reason for the existence of the VPC"
    default = "Separate network for experimentation"
}

variable "creator" {
    description = "Person creating the VPC"
    default = "nobody@example.com"
}

variable "environment" {
    description = "Context the VPC will be used in, e.g. production"
    default = "development"
}

variable "freetext" {
    description = "Information that does not fit in the other tags"
    default = "No notes at this time"
}
