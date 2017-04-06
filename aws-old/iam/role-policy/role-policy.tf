#-------------------- inputs -----------------------

variable "role" {
    description = "The IAM role to attach to the policy."
}

variable "policy_path" {
    description = "The path to the policy document."
}

variable "name" {
    description = "The name of the policy."
}

#-------------------- resources -----------------------

resource "aws_iam_role_policy" "policy" {
    name = "${var.name}"
    role = "${var.role}"
    policy = "${file( var.policy_path )}"
}

#-------------------- outputs -----------------------

output "id" {
    value = "${aws_iam_role_policy.policy.id}"
}

output "name" {
    value = "${aws_iam_role_policy.policy.name}"
}

output "policy" {
    value = "${aws_iam_role_policy.policy.policy}"
}

output "role" {
    value = "${aws_iam_role_policy.policy.role}"
}

