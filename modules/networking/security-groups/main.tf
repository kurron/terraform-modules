terraform {
    required_version = ">= 0.10.3"
    backend "s3" {}
}

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "${var.region}"
}

data "terraform_remote_state" "vpc" {
    backend = "s3"
    config {
        bucket = "${var.vpc_bucket}"
        key    = "${var.vpc_key}"
        region = "${var.vpc_region}"
    }
}

resource "aws_security_group" "bastion_access" {
    name_prefix = "bastion-"
    description = "Controls access to the Bastion boxes"
    vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"
    tags {
        Name        = "Bastion Access"
        Project     = "${var.project}"
        Purpose     = "Controls access to the Bastion boxes"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "${var.freetext}"
    }

}

resource "aws_security_group" "api_gateway_access" {
    name_prefix = "api-gateway-"
    description = "Controls access to the API Gateway"
    vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"
    tags {
        Name        = "API Gateway Access"
        Project     = "${var.project}"
        Purpose     = "Controls access to the API Gateway"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "${var.freetext}"
    }

}
