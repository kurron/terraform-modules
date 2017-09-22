output "start_arn" {
    value = "${aws_cloudwatch_event_rule.ec2_start.arn}"
    description = "Amazon Resource Name (ARN) identifying the CloudWatch Event rule starting scheduled instances."
}
