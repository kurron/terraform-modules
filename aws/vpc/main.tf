variable "name" {
    description = "the name of your stack, e.g. \"alpha-prime\""
}

variable "project" {
    description = "project code to assign your stack, e.g. \"Weapon X\""
}

variable "purpose" {
    description = "why you are building your stack, e.g. \"load testing\""
}

variable "creator" {
     description = "entity creating the stack, e.g. \"blacksmith@example.com\""
}

variable "environment" {
     description = "categorization of the stack, e.g. \"development, test, staging, production\""
}

variable "freetext" {
    description = "any notes you might want to add, e.g. \"Testing out Terraform\""
}

variable "cidr" {
      description = "The CIDR block to provision for the VPC"
}

resource "aws_vpc" "main" {
    cidr_block = "${var.cidr}"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags {
        Name = "${var.name}"
        Purpose = "${var.purpose}"
        Project = "${var.project}"
        Creator = "${var.creator}"
        Environment = "${var.environment}"
        Freetext = "${var.freetext}"
    }
}
