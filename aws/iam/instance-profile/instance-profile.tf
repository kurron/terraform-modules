#-------------------- inputs -----------------------

variable "name" {
    description = "The name of the profile."
}

variable "path" {
    description = "Path in which to create the profile."
    default = "/"
}

variable "roles" {
    description = "A list of role names to include in the profile."
}

#-------------------- resources -----------------------

resource "aws_iam_instance_profile" "profile" {
    name = "${var.name}"
    path = "${var.path}"
    roles = ["${var.roles}"]
}

#-------------------- outputs -----------------------

output "id" {
    value = "${aws_iam_instance_profile.profile.id}"
}

output "arn" {
    value = "${aws_iam_instance_profile.profile.arn}"
}

output "create_date" {
    value = "${aws_iam_instance_profile.profile.create_date}"
}

output "name" {
    value = "${aws_iam_instance_profile.profile.name}"
}

output "path" {
    value = "${aws_iam_instance_profile.profile.path}"
}

output "roles" {
    value = "${aws_iam_instance_profile.profile.roles}"
}

output "unique_id" {
    value = "${aws_iam_instance_profile.profile.unique_id}"
}
