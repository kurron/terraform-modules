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

resource "aws_ecs_cluster" "main" {
    name = "${var.cluster_name}"

    lifecycle {
        create_before_destroy = true
    }
}
