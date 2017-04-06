# ------------ inputs ----------------------

variable "family" {
    description = "The family, unique name for your task definition."
}

variable "definition" {
    description = "The path to the list of container definitions in JSON format."
}

# ------------ resources ----------------------

resource "aws_ecs_task_definition" "task" {
    family = "${var.family}"
    container_definitions = "${file( var.definition )}"

#   lifecycle { create_before_destroy = true }
}

# ------------ outputs ----------------------

output "id" {
    value = "${aws_ecs_task_definition.task.arn}"
}

output "family" {
    value = "${aws_ecs_task_definition.task.family}"
}

output "revision" {
    value = "${aws_ecs_task_definition.task.revision}"
}

