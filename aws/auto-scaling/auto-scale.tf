resource "aws_autoscaling_group" "aag" {
    name = "${var.name}"
    max_size = "${var.max_size}" 
    min_size = "${var.min_size}" 
    launch_configuration = "${var.launch_configuration_name}"
    health_check_grace_period = "${var.health_check_grace_period}" 
    health_check_type = "${var.health_check_type}"
    desired_capacity = "${var.desired_capacity}" 
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

