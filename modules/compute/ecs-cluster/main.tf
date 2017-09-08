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

data "aws_ami" "ecs_ami" {
    most_recent = true
    name_regex  = "^amzn-ami-.*amazon-ecs-optimized$"
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

resource "aws_ecs_cluster" "main" {
    name = "${var.cluster_name}"

    lifecycle {
        create_before_destroy = true
    }
}

data "template_file" "ecs_cloud_config" {
    template = "${file("${path.module}/cloud-config.yml.template")}"
    vars {
        cluster_name      = "${aws_ecs_cluster.main.name}"
    }
}

data "template_cloudinit_config" "cloud_config" {
    gzip          = false
    base64_encode = false
    part {
        content_type = "text/cloud-config"
        content      = "${data.template_file.ecs_cloud_config.rendered}"
    }
}

resource "aws_launch_configuration" "worker_spot" {
    name_prefix                 = "worker-"
    image_id                    = "${data.aws_ami.ecs_ami.id}"
    instance_type               = "${var.instance_type}"
    iam_instance_profile        = "${data.terraform_remote_state.iam.profile}"
    key_name                    = "${var.ssh_key_name}"
    security_groups             = ["${data.terraform_remote_state.security-groups.ec2_id}"]
    user_data                   = "${data.template_cloudinit_config.cloud_config.rendered}"
    associate_public_ip_address = false
    enable_monitoring           = true
    ebs_optimized               = "${var.ebs_optimized}"
    spot_price                  = "${var.spot_price}"
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "worker_spot" {
    name_prefix               = "Worker"
    max_size                  = "${var.spot_max_size}"
    min_size                  = "${var.spot_min_size}"
    availability_zones        = ["${data.terraform_remote_state.vpc.availability_zones}"]
    default_cooldown          = "${var.cooldown}"
    launch_configuration      = "${aws_launch_configuration.worker_spot.name}"
    health_check_grace_period = "${var.health_check_grace_period }"
    health_check_type         = "EC2"
    desired_capacity          = "${var.spot_desired_capacity}"
    vpc_zone_identifier       = ["${data.terraform_remote_state.vpc.private_subnet_ids}"]
    termination_policies      = ["ClosestToNextInstanceHour", "OldestInstance", "Default"]
    enabled_metrics           = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
    lifecycle {
        create_before_destroy = true
    }
    tag {
        key                 = "Name"
        value               = "Worker (spot)"
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

resource "aws_autoscaling_schedule" "spot_scale_up" {
    autoscaling_group_name = "${aws_autoscaling_group.worker_spot.name}"
    scheduled_action_name  = "Scale Up (spot)"
    recurrence             = "${var.spot_scale_up_cron}"
    min_size               = "${var.spot_min_size}"
    max_size               = "${var.spot_max_size}"
    desired_capacity       = "${var.spot_desired_capacity}"
}

resource "aws_autoscaling_schedule" "spot_scale_down" {
    autoscaling_group_name = "${aws_autoscaling_group.worker_spot.name}"
    scheduled_action_name  = "Scale Down (spot)"
    recurrence             = "${var.spot_scale_down_cron}"
    min_size               = "${var.spot_scale_down_min_size}"
    max_size               = "${var.spot_max_size}"
    desired_capacity       = "${var.spot_scale_down_desired_capacity}"
}
