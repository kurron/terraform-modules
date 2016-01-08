provider "aws" {
    region = "${var.aws_region}"
    max_retries = 10
}

module "vpc" {
    source = "aws/vpc"
    aws_region = "${var.aws_region}"
    name = "Example VPC"
    realm = "${var.realm}"
    purpose = "${var.purpose}"
    managed_by = "${var.managed_by}"
}

module "all-ports" {
    source = "aws/security-groups/wide-open"
    vpc_id =  "${module.vpc.id}"
    name = "VPC Wide Open"
    realm = "${var.realm}"
    purpose = "${var.purpose}"
    managed_by = "${var.managed_by}"
}

module "secure-http" {
    source = "aws/security-groups/secure-http"
    vpc_id =  "${module.vpc.id}"
    name = "VPC Secure HTTP"
    realm = "${var.realm}"
    purpose = "${var.purpose}"
    managed_by = "${var.managed_by}"
}

module "insecure-http" {
    source = "aws/security-groups/insecure-http"
    vpc_id =  "${module.vpc.id}"
    name = "VPC Insecure HTTP"
    realm = "${var.realm}"
    purpose = "${var.purpose}"
    managed_by = "${var.managed_by}"
}

module "ssh" {
    source = "aws/security-groups/ssh"
    vpc_id =  "${module.vpc.id}"
    name = "VPC SSH"
    realm = "${var.realm}"
    purpose = "${var.purpose}"
    managed_by = "${var.managed_by}"
}
