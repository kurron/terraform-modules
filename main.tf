provider "aws" {
    region = "${var.aws_region}"
    max_retries = 10
}

module "aws-vpc" {
    source = "aws-vpc"
    aws_region = "${var.aws_region}"
    name = "Example VPC"
}
