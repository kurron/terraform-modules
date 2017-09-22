output "start_arn" {
    value = "${aws_lambda_function.start_lambda.arn}"
    description = "Amazon Resource Name (ARN) identifying the function that starts the instances."
}

output "start_last_modified" {
    value = "${aws_lambda_function.start_lambda.last_modified}"
    description = "The date the start Lambda was last modified."
}
