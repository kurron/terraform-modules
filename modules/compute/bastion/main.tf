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

data "aws_ami" "amazon_linux_ami" {
    most_recent      = true
    name_regex = "amzn-ami-hvm-*"
    owners     = ["amazon"]
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

resource "aws_security_group" "ssh_only" {
    name        = "SSH Only"
    description = "Allow only inbound SSH traffic"
    vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"
    egress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${data.terraform_remote_state.vpc.vpc_cidr}"]
    }
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = "${var.ssh_ingress_cidr_blocks}"
    }
    tags {
        Name        = "SSH Only"
        Project     = "${var.project}"
        Purpose     = "Restrict SSH traffic to specific ip ranges"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "No notes yet."
    }
}

resource "aws_launch_configuration" "bastion" {
    name_prefix   = "bastion-"
    image_id      = "${data.aws_ami.amazon_linux_ami.id}"
    instance_type = "${var.instance_type}"
    key_name = "${var.ssh_key_name}"
    security_groups = ["${aws_security_group.ssh_only.id}"]
    associate_public_ip_address = true
    enable_monitoring = true
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "bastion" {
    name_prefix               = "Bastion-"
    max_size                  = "${var.max_size}"
    min_size                  = "${var.min_size}"
    availability_zones        = ["${data.terraform_remote_state.vpc.vpc_availability_zones}"]
    default_cooldown          = "${var.cooldown}"
    launch_configuration      = "${aws_launch_configuration.bastion.name}"
    health_check_grace_period = "${var.health_check_grace_period }"
    health_check_type         = "EC2"
    desired_capacity          = "${var.desired_capacity}"
    vpc_zone_identifier       = ["${data.terraform_remote_state.vpc.vpc_public_subnet_ids}"]
    termination_policies      = ["ClosestToNextInstanceHour", "OldestInstance", "Default"]
    enabled_metrics           = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
    lifecycle {
        create_before_destroy = true
    }
    tag {
        key                 = "Name"
        value               = "Bastion"
        propagate_at_launch = true
    }
    tag {
        key                 = "Project"
        value               = "${var.project}"
        propagate_at_launch = true
    }
    tag {
        key                 = "Purpose"
        value               = "Ensure we always have a way to SSH into private instances"
        propagate_at_launch = true
    }
    tag {
        key                 = "Creator"
        value               = "${var.creator}"
        propagate_at_launch = true
    }
    tag {
        key                 = "Environment"
        value               = "${var.environment}"
        propagate_at_launch = true
    }
    tag {
        key                 = "Freetext"
        value               = "Should we set some scaling policies?"
        propagate_at_launch = true
    }
}
