# ------------ inputs ----------------------

variable "name" {
    description = "The name of this ELB."
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

variable "subnets" {
    description = "A list of subnet IDs to attach to the ELB."
}

variable "internal" {
    description = "If true, ELB will be an internal ELB."
    default = "false"
}

variable "security_groups" {
    description = "A list of security group IDs to assign to the ELB."
    default = ""
}

variable "cross_zone_balancing" {
    description = "Enable cross-zone load balancing."
    default = "true"
}

variable "idle_timeout" {
    description = "The time in seconds that the connection is allowed to be idle."
    default = "60"
}

variable "connection_draining" {
    description = "TODO"
    default = "true"
}

variable "connection_draining_timeout" {
    description = "The time in seconds to allow for connections to drain."
    default = "60"
}

variable "insecure_port" {
    description = "The port to listen on for the load balancer."
    default = "80"
}

variable "instance_port" {
    description = "The port on the instance to route to."
    default = "80"
}

variable "healthy_threshold" {
    description = "The number of checks before the instance is declared healthy."
    default = "3"
}

variable "unhealthy_threshold" {
    description = "The number of checks before the instance is declared unhealthy."
    default = "2"
}

variable "timeout" {
    description = "The length of time, in seconds, before the health check times out."
    default = "10"
}

variable "interval" {
    description = "The interval, in seconds, between health checks."
    default = "15"
}
# ------------ resources ----------------------

resource "aws_elb" "elb" {
    name = "${var.name}"
    subnets = ["${var.subnets}"]
    internal = "${var.internal}" 
    security_groups = ["${var.security_groups}"]
    cross_zone_load_balancing = "${var.cross_zone_balancing}"
    idle_timeout = "${var.idle_timeout}" 
    connection_draining = "${var.connection_draining}"
    connection_draining_timeout = "${var.connection_draining_timeout}"

    listener {
        lb_port           = "${var.insecure_port}"
        lb_protocol       = "http"
        instance_port     = "${var.instance_port}"
        instance_protocol = "http"
    }

    health_check {
        healthy_threshold   = "${var.healthy_threshold}" 
        unhealthy_threshold = "${var.unhealthy_threshold}" 
        timeout             = "${var.timeout}"
        interval            = "${var.interval}"
        target              = "HTTP:${var.instance_port}/"
    }

#   lifecycle { create_before_destroy = true }

    tags {
        Name = "${var.name}"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.managed_by}"
    }
}

# ------------ outputs ----------------------

output "id" {
    value = "${aws_elb.elb.id}"
}

output "name" {
    value = "${aws_elb.elb.name}"
}

output "dns_name" {
    value = "${aws_elb.elb.dns_name}"
}
