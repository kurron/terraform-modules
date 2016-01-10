# ------------ inputs ----------------------

variable "name" {
    description = "The name of this auto-scaling group."
    default = "Primary Scaling Group"
}

variable "realm" {
    description = "The logical group that all of the infrastructure belongs to. Similar idea to an AWS stack."
    default = "terraform-experimentation"
}

variable "purpose" {
    description = "A tag indicating why all the infrastructure exists, eg. load-testing."
    default = "Prototyping"
}

variable "managed_by" {
    description = "The tool that manages this resource."
    default = "Terraform"
}

variable "max_size" {
    description = "The maximum number of EC2 instances to have running in the group."
    default = "6"
}

variable "min_size" {
    description = "The minimum number of EC2 instances to have running in the group."
    default = "3"
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
    default = "3"
}

variable "force_delete" {
    description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate."
    default = "false"
}

variable "zone_ids" {
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

# ------------ resources ----------------------

resource "aws_autoscaling_group" "aag" {
    name = "${var.name}"
    max_size = "${var.max_size}" 
    min_size = "${var.min_size}" 
    launch_configuration = "${var.launch_configuration_name}"
    health_check_grace_period = "${var.health_check_grace_period}" 
    health_check_type = "${var.health_check_type}"
#   desired_capacity = "${var.desired_capacity}" 
    force_delete = "${var.force_delete}"
    vpc_zone_identifier = ["${var.zone_ids}"]
    wait_for_capacity_timeout = "${var.wait_for_capacity_timeout}"

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

# ------------ outputs ----------------------

output "id" {
    value = "${aws_autoscaling_group.aag.id}"
}

output "name" {
    value = "${aws_autoscaling_group.aag.name}"
}
