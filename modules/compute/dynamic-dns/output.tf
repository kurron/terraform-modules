output "dynamic_dns_arn" {
    value = "${aws_lambda_function.dynamic_dns.arn}"
    description = "Amazon Resource Name (ARN) identifying the function that registers EC2 instances with Route53."
}

output "dynamic_dns_modified" {
    value = "${aws_lambda_function.dynamic_dns.last_modified}"
    description = "The date the start Lambda was last modified."
}

output "dynamic_dns_name" {
    value = "${aws_lambda_function.dynamic_dns.function_name}"
    description = "Function name of the Dynamic DNS Lambda"
}
