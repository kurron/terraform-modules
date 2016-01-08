provider "aws" {
    region = "${var.aws_region}"
    max_retries = 10
}

module "aws-vpc" {
    source = "aws/vpc"
    aws_region = "${var.aws_region}"
    name = "Example VPC"
    realm = "${var.realm}"
    purpose = "${var.purpose}"
    managed_by = "${var.managed_by}"
}

module "aws-vpc-security-group" {
    source = "aws-security-groups/wide-open"
#   aws_region = "${var.aws_region}"
    vpc_id =  "${module.aws-vpc.id}"
    name = "VPC Wide Open"
    realm = "${var.realm}"
    purpose = "${var.purpose}"
    managed_by = "${var.managed_by}"
}
