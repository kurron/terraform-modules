# ------------ inputs ----------------------

variable "name" {
    description = "The name of the repository."
    value = "Docker Registry"
}

variable "policy" {
    description = "he policy document. This is a JSON formatted string."
}

# ------------ resources ----------------------

resource "aws_ecr_repository" "repository" {
    name = "${var.name}"

    lifecycle { create_before_destroy = true }
}

resource "aws_ecr_repository_policy" "policy" {
    repository = "${aws_ecr_repository.repository.name}"
    policy = "${var.policy}"
}

# ------------ outputs ----------------------

output "id" {
    value = "${aws_ecr_repository_policy.policy.registry_id}"
}

output "name" {
    value = "${aws_ecr_repository_policy.policy.repository}"
}
