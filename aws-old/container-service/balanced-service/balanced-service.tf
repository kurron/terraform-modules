# ------------ inputs ----------------------

variable "name" {
    description = "The name of the service (up to 255 letters, numbers, hyphens, and underscores)."
}

variable "cluster" {
    description = "ARN of an ECS cluster."
}

variable "task" {
    description = "The family and revision (family:revision) or full ARN of the task definition that you want to run in your service."
}

variable "desired_count" {
    description = "The number of instances of the task definition to place and keep running."
}

variable "role" {
    description = "IAM role that allows your Amazon ECS container agent to make calls to your load balancer on your behalf."
}

variable "elb" {
    description = "The name of the load balancer."
}

variable "container_name" {
    description = "The name of the container to associate with the load balancer (as it appears in a container definition)."
}

variable "container_port" {
    description = "The port on the container to associate with the load balancer."
}

# ------------ resources ----------------------

resource "aws_ecs_service" "service" {
    name = "${var.name}"
    cluster = "${var.cluster}"
    task_definition = "${var.task}"
    desired_count = "${var.desired_count}" 
    iam_role = "${var.role}"
#   depends_on = ["${var.role}"]

    lifecycle { create_before_destroy = true }

    load_balancer {
        elb_name = "${var.elb}"
        container_name = "${var.container_name}"
        container_port = "${var.container_port}" 
    }
}

# ------------ outputs ----------------------

output "id" {
    value = "${aws_ecs_service.service.id}"
}

output "name" {
    value = "${aws_ecs_service.service.name}"
}

output "cluster" {
    value = "${aws_ecs_service.service.cluster}"
}

output "role" {
    value = "${aws_ecs_service.service.role}"
}

output "count" {
    value = "${aws_ecs_service.service.desired_count}"
}

