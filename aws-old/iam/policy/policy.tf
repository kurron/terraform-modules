#-------------------- inputs -----------------------

variable "description" {
    description = "Description of the IAM policy."
}

variable "path" {
    description = "Path in which to create the policy. "
    default = "/"
}

variable "policy_path" {
    description = "The path to the policy document.."
}

variable "name" {
    description = "The name of the policy."
}

#-------------------- resources -----------------------

resource "aws_iam_policy" "policy" {
    name = "${var.name}"
    path = "${var.path}"
    description = "${var.description}"
    policy = "${file( var.policy_path )}"
}

#-------------------- outputs -----------------------

output "id" {
    value = "${aws_iam_policy.policy.id}"
}

output "arn" {
    value = "${aws_iam_policy.policy.arn}"
}

output "description" {
    value = "${aws_iam_policy.policy.description}"
}

output "name" {
    value = "${aws_iam_policy.policy.name}"
}

output "path" {
    value = "${aws_iam_policy.policy.path}"
}

output "policy" {
    value = "${aws_iam_policy.policy.policy}"
}

