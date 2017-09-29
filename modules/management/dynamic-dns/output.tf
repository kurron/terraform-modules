output "dynamic_dns_arn" {
    value = "${aws_cloudwatch_event_rule.dynamic_dns.arn}"
    description = "Amazon Resource Name (ARN) identifying the CloudWatch Event rule triggering dynamic DNS."
}
