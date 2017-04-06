# ------------ inputs ----------------------

variable "name" {
    description = "The name of the cluster (up to 255 letters, numbers, hyphens, and underscores)."
}

# ------------ resources ----------------------

resource "aws_ecs_cluster" "cluster" {
    name = "${var.name}"
#   lifecycle { create_before_destroy = true }
}

# ------------ outputs ----------------------

output "id" {
    value = "${aws_ecs_cluster.cluster.id}"
}

output "name" {
    value = "${aws_ecs_cluster.cluster.name}"
}
