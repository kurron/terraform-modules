terraform {
    required_version = ">= 0.9.0"
}

variable "name" {
    description = "the name of your stack, e.g. \"segment\""
}

variable "project" {
    description = "project code to assign your stack, e.g. \"Weapon X\""
}

variable "purpose" {
    description = "why you are building your stack, e.g. \"load testing\""
    default = "Terraform experimentation"
}

variable "creator" {
     description = "entity creating the stack, e.g. \"blacksmith@example.com\""
     default = "Terraform"
}

variable "environment" {
     description = "categorization of the stack, e.g. \"development, test, staging, production\""
     default = "development"
}

variable "freetext" {
    description = "any notes you might want to add, e.g. \"Testing out Terraform\""
    default = "No notes yet."
}

variable "region" {
    description = "The AWS region"
    default = "us-west-2"
}

variable "cidr" {
      description = "The CIDR block to provision for the VPC"
      default = "10.0.0.0/24"
}

module "defaults" {
    source = "./aws/defaults"
    region = "${var.region}"
    cidr   = "${var.cidr}"
}
