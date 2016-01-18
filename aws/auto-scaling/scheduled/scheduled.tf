# ------------ inputs ----------------------

variable "name" {
    description = "The name of this auto-scaling group."
}

variable "realm" {
    description = "The logical group that all of the infrastructure belongs to. Similar idea to an AWS stack."
}

variable "purpose" {
    description = "A tag indicating why all the infrastructure exists, eg. load-testing."
}

variable "managed_by" {
    description = "The tool that manages this resource."
}

variable "max_size" {
    description = "The maximum number of EC2 instances to have running in the group."
}

variable "min_size" {
    description = "The minimum number of EC2 instances to have running in the group."
}

variable "health_check_grace_period" {
    description = "Seconds after instance comes into service before checking health."
    default = "300"
}

variable "health_check_type" {
    description = "Controls how health checking is done. EC2 or ELB are valid values."
    default = "EC2"
}

variable "desired_capacity" {
    description = "The number of Amazon EC2 instances that should be running in the group."
}

variable "force_delete" {
    description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate."
    default = "false"
}

variable "subnet_ids" {
    description = "A list of subnet IDs to launch resources in."
}

variable "force_delete" {
    description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate."
    default = "false"
}

variable "wait_for_capacity_timeout" {
    description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out."
    default = "10m"
}

variable "launch_configuration_name" {
    description = "The name of the launch configuration to use."
}

variable "cooldown" {
    description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start."
    default = "60"
}

variable "up_name" {
    description = "The name of the spin-up scaling action."
}

variable "up_min_size" {
    description = "The minimum size for the scaling group"
}

variable "up_max_size" {
    description = "The maximum size for the scaling group"
}

variable "up_desired_capacity" {
    description = "The number of EC2 instances that should be running in the group."
}

variable "up_cron" {
    description = "The time when recurring future actions will start."
    default = "0 8 1-31 1-12 1-5"
}

variable "down_name" {
    description = "The name of the spin-down scaling action."
}

variable "down_min_size" {
    description = "The minimum size for the scaling group"
    default = "0"
}

variable "down_max_size" {
    description = "The maximum size for the scaling group"
    default = "0"
}

variable "down_desired_capacity" {
    description = "The number of EC2 instances that should be running in the group."
    default = "0"
}

variable "down_cron" {
    description = "The time when recurring future actions will start."
    default = "0 17 1-31 1-12 1-7"
}

variable "schedule_start" {
    description = "Temporarily required until the next release of Terraform."
}

# ------------ resources ----------------------

resource "aws_autoscaling_group" "aag" {
    name = "${var.name}"
    max_size = "${var.max_size}" 
    min_size = "${var.min_size}" 
    launch_configuration = "${var.launch_configuration_name}"
    health_check_grace_period = "${var.health_check_grace_period}" 
    health_check_type = "${var.health_check_type}"
    desired_capacity = "${var.desired_capacity}" 
    force_delete = "${var.force_delete}"
    vpc_zone_identifier = ["${var.subnet_ids}"]
    wait_for_capacity_timeout = "${var.wait_for_capacity_timeout}"

#   lifecycle { create_before_destroy = true }

    tag {
        key = "Name"
        value = "${var.name}"
        propagate_at_launch = true
    }

    tag {
        key = "Realm"
        value = "${var.realm}"
        propagate_at_launch = true
    }

    tag {
        key = "Purpose"
        value = "${var.purpose}"
        propagate_at_launch = true
    }

    tag {
        key = "Managed-By"
        value = "${var.managed_by}"
        propagate_at_launch = true
    }
}

resource "aws_autoscaling_policy" "policy" {
    name = "${var.name}"
    scaling_adjustment = "${var.desired_capacity}" 
    adjustment_type = "ExactCapacity"
    cooldown = "${var.cooldown}"
    autoscaling_group_name = "${aws_autoscaling_group.aag.name}"
}

resource "aws_autoscaling_schedule" "up" {
    scheduled_action_name = "${var.up_name}"
    min_size = "${var.up_min_size}" 
    max_size = "${var.up_max_size}" 
    desired_capacity = "${var.up_desired_capacity}"
    recurrence = "${var.up_cron}"
    autoscaling_group_name = "${aws_autoscaling_group.aag.name}"

    # necessary until the next release of Terraform
    start_time = "${var.schedule_start}" 
    end_time = "2016-12-31T00:00:00Z" 
}

resource "aws_autoscaling_schedule" "down" {
    scheduled_action_name = "${var.down_name}"
    min_size = "${var.down_min_size}" 
    max_size = "${var.down_max_size}" 
    desired_capacity = "${var.down_desired_capacity}"
    recurrence = "${var.down_cron}"
    autoscaling_group_name = "${aws_autoscaling_group.aag.name}"

    # necessary until the next release of Terraform
    start_time = "${var.schedule_start}" 
    end_time = "2016-11-31T00:00:00Z" 
}

# ------------ outputs ----------------------

output "id" {
    value = "${aws_autoscaling_group.aag.id}"
}

output "name" {
    value = "${aws_autoscaling_group.aag.name}"
}
