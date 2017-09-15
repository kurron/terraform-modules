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

data "terraform_remote_state" "iam" {
    backend = "s3"
    config {
        bucket = "${var.iam_bucket}"
        key    = "${var.iam_key}"
        region = "${var.iam_region}"
    }
}

data "terraform_remote_state" "bastion" {
    backend = "s3"
    config {
        bucket = "${var.bastion_bucket}"
        key    = "${var.bastion_key}"
        region = "${var.bastion_region}"
    }
}

data "aws_ami" "ecs_ami" {
    most_recent = true
    name_regex  = "^amzn-ami-.*-amazon-ecs-optimized$"
    owners      = ["amazon"]
    filter {
       name   = "architecture"
       values = ["x86_64"]
    }
    filter {
       name   = "image-type"
       values = ["machine"]
    }
    filter {
       name   = "state"
       values = ["available"]
    }
    filter {
       name   = "virtualization-type"
       values = ["hvm"]
    }
    filter {
       name   = "hypervisor"
       values = ["xen"]
    }
    filter {
       name   = "root-device-type"
       values = ["ebs"]
    }
}

data "template_file" "ecs_cloud_config" {
    template = "${file("${path.module}/cloud-config.yml.template")}"
}

data "template_cloudinit_config" "cloud_config" {
    gzip          = false
    base64_encode = false
    part {
        content_type = "text/cloud-config"
        content      = "${data.template_file.ecs_cloud_config.rendered}"
    }
}

resource "aws_instance" "docker" {
    count = 2

    ami                    = "${data.aws_ami.ecs_ami.id}"
    ebs_optimized          = "${var.ebs_optimized}"
    instance_type          = "${var.instance_type}"
    key_name               = "${data.terraform_remote_state.bastion.ssh_key_name}"
    monitoring             = true
    vpc_security_group_ids = ["${data.terraform_remote_state.security-groups.ec2_id}"]
    subnet_id              = "${element( data.terraform_remote_state.vpc.private_subnet_ids, count.index )}"
    user_data              = "${data.template_cloudinit_config.cloud_config.rendered}"
    iam_instance_profile   = "${data.terraform_remote_state.iam.profile}"

    tags {
        Name = "${format( "Docker %02d", count.index+1 )}"
        Project = "${var.project}"
        Purpose = "Run Docker containers"
        Creator = "${var.creator}"
        Environment = "${var.environment}"
        Freetext = "${var.freetext}"
    }
    volume_tags {
        Name = "${format( "Docker %02d", count.index+1 )}"
        Project = "${var.project}"
        Purpose = "Run Docker containers"
        Creator = "${var.creator}"
        Environment = "${var.environment}"
        Freetext = "${var.freetext}"
    }
}
