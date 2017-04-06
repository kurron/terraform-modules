#-------------------- inputs -----------------------

variable "name" {
    description = "The name of the role."
}

variable "policy_path" {
    description = "Path to the policy file that grants an entity permission to assume the role."
}

variable "path" {
    description = "Path in which to create the policy. "
    default = "/"
}

#-------------------- resources -----------------------

resource "aws_iam_role" "role" {
    name = "${var.name}"
    path = "${var.path}"
    assume_role_policy = "${file( var.policy_path )}"
}

#-------------------- outputs -----------------------

output "id" {
    value = "${aws_iam_role.role.unique_id}"
}


output "arn" {
    value = "${aws_iam_role.role.arn}"
}

