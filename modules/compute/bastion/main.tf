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
        cidr_blocks = ["${data.terraform_remote_state.vpc.cidr}"]
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
        Purpose     = "${var.purpose}"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "${var.freetext}"
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
    availability_zones        = ["${data.terraform_remote_state.vpc.availability_zones}"]
    default_cooldown          = "${var.cooldown}"
    launch_configuration      = "${aws_launch_configuration.bastion.name}"
    health_check_grace_period = "${var.health_check_grace_period }"
    health_check_type         = "EC2"
    desired_capacity          = "${var.desired_capacity}"
    vpc_zone_identifier       = ["${data.terraform_remote_state.vpc.public_subnet_ids}"]
    termination_policies      = ["ClosestToNextInstanceHour", "OldestInstance", "Default"]
    enabled_metrics           = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
    lifecycle {
        create_before_destroy = true
    }
    tag {
        key                 = "Name"
        value               = "${var.name}"
        propagate_at_launch = true
    }
    tag {
        key                 = "Project"
        value               = "${var.project}"
        propagate_at_launch = true
    }
    tag {
        key                 = "Purpose"
        value               = "${var.purpose}"
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
        value               = "${var.freetext}"
        propagate_at_launch = true
    }
}

resource "aws_autoscaling_schedule" "scale_up" {
    autoscaling_group_name = "${aws_autoscaling_group.bastion.name}"
    scheduled_action_name  = "Scale Up"
    recurrence             = "${var.scale_up_cron}"
    min_size               = "${var.min_size}"
    max_size               = "${var.max_size}"
    desired_capacity       = "${var.desired_capacity}"
}

resource "aws_autoscaling_schedule" "scale_down" {
    autoscaling_group_name = "${aws_autoscaling_group.bastion.name}"
    scheduled_action_name  = "Scale Down"
    recurrence             = "${var.scale_down_cron}"
    min_size               = "${var.scale_down_min_size}"
    max_size               = "${var.max_size}"
    desired_capacity       = "${var.scale_down_desired_capacity}"
}
