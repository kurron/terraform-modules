terraform {
    required_version = ">= 0.10.3"
    backend "s3" {}
}

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "${var.region}"
}

data "terraform_remote_state" "iam" {
    backend = "s3"
    config {
        bucket = "${var.iam_bucket}"
        key    = "${var.iam_key}"
        region = "${var.iam_region}"
    }
}

data "terraform_remote_state" "lambda" {
    backend = "s3"
    config {
        bucket = "${var.lambda_bucket}"
        key    = "${var.lambda_key}"
        region = "${var.lambda_region}"
    }
}

resource "aws_cloudwatch_event_rule" "ec2_start" {
    name        = "trigger-ec2-start"
    schedule_expression = "${var.start_cron_expression}"
    description = "Triggers the Lambda what will start scheduled EC2 instances"
    is_enabled = true
}

resource "aws_cloudwatch_event_target" "start_lambda" {
    rule      = "${aws_cloudwatch_event_rule.ec2_start.name}"
    arn       = "${data.terraform_remote_state.lambda.start_arn}"
}

resource "aws_cloudwatch_event_rule" "ec2_stop" {
    name        = "trigger-ec2-stop"
    schedule_expression = "${var.stop_cron_expression}"
    description = "Triggers the Lambda what will stop scheduled EC2 instances"
    is_enabled = false
}

resource "aws_cloudwatch_event_target" "stop_lambda" {
    rule      = "${aws_cloudwatch_event_rule.ec2_stop.name}"
    arn       = "${data.terraform_remote_state.lambda.stop_arn}"
}
