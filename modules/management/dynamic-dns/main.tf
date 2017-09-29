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

resource "aws_cloudwatch_event_rule" "dynamic_dns" {
    name          = "dynamic-dns"
    description   = "Triggers the Lambda what will manage registration of EC2 instances with Route53"
    is_enabled    = true
    event_pattern = <<PATTERN
{
    "source":["aws.ec2"],
    "detail-type":["EC2 Instance State-change Notification"],
    "detail": {
        "state":["running","shutting-down","stopped"]
    }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "dynamic_dns" {
    rule = "${aws_cloudwatch_event_rule.dynamic_dns.name}"
    arn  = "${data.terraform_remote_state.lambda.dynamic_dns_arn}"
}

resource "aws_lambda_permission" "allow_dynamic_dns" {
      action         = "lambda:InvokeFunction"
      function_name  = "${data.terraform_remote_state.lambda.dynamic_dns_function_name}"
      principal      = "events.amazonaws.com"
      statement_id   = "AllowExecutionFromCloudWatch"
      source_arn     = "${aws_cloudwatch_event_rule.dynamic_dns.arn}"
}
