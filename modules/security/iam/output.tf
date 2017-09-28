output "default_ecs_role_id" {
  value = "${aws_iam_role.default_ecs_role.id}"
}

output "arn" {
  value = "${aws_iam_role.default_ecs_role.arn}"
}

output "profile" {
  value = "${aws_iam_instance_profile.default_ecs.id}"
}

output "cross_account_ecr_pull_role_id" {
  value = "${aws_iam_role.cross_account_ecr_pull_role.id}"
}

output "cross_account_ecr_pull_role_arn" {
  value = "${aws_iam_role.cross_account_ecr_pull_role.arn}"
}

output "cross_account_ecr_pull_profile_id" {
  value = "${aws_iam_instance_profile.cross_account_ecr_pull_profile.id}"
}

output "start_stop_role_id" {
  value = "${aws_iam_role.ec2_start_stop.id}"
}

output "start_stop_role_arn" {
  value = "${aws_iam_role.ec2_start_stop.arn}"
}

output "start_stop_profile_id" {
  value = "${aws_iam_instance_profile.ec2_start_stop.id}"
}

output "dynamic_dns_role_id" {
  value = "${aws_iam_role.dynamic_dns.id}"
}

output "dynamic_dns_role_arn" {
  value = "${aws_iam_role.dynamic_dns.arn}"
}
