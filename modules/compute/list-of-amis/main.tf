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

data "terraform_remote_state" "security-groups" {
    backend = "s3"
    config {
        bucket = "${var.security_groups_bucket}"
        key    = "${var.security_groups_key}"
        region = "${var.security_groups_region}"
    }
}

resource "aws_instance" "main" {
    count                       = "${length( compact( var.ami_list ) )}"
    ami                         = "${element( var.ami_list, count.index )}"
    instance_type               = "${var.instance_type}"
    key_name                    = "${var.ssh_key_name}"
    vpc_security_group_ids      = ["${data.terraform_remote_state.security-groups.ec2_id}"]
    subnet_id                   = "${data.terraform_remote_state.vpc.public_subnet_ids[0]}"
    associate_public_ip_address = true
    tags {
        Name        = "${element( var.instance_names, count.index )}"
        Project     = "${var.project}"
        Purpose     = "Realization of the AMI"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "${var.freetext}"
    }
    ebs_block_device = {
        device_name = "/dev/xvdf"
        volume_type = "gp2"
        volume_size = "${var.volume_size}"
        delete_on_termination = "true"
    }
}
