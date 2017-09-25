output "start_arn" {
    value = "${aws_lambda_function.start_lambda.arn}"
    description = "Amazon Resource Name (ARN) identifying the function that starts the instances."
}

output "start_last_modified" {
    value = "${aws_lambda_function.start_lambda.last_modified}"
    description = "The date the start Lambda was last modified."
}

output "start_function_name" {
    value = "${aws_lambda_function.start_lambda.function_name}"
    description = "Function name of the start Lambda"
}

output "stop_arn" {
    value = "${aws_lambda_function.stop_lambda.arn}"
    description = "Amazon Resource Name (ARN) identifying the function that stops the instances."
}

output "stop_last_modified" {
    value = "${aws_lambda_function.stop_lambda.last_modified}"
    description = "The date the stop Lambda was last modified."
}

output "stop_function_name" {
    value = "${aws_lambda_function.stop_lambda.function_name}"
    description = "Function name of the stop Lambda"
}
