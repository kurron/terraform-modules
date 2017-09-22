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

data "template_file" "start_lambda" {
    template = "${file("${path.module}/start-lambda.py.template")}"
    vars {
        project = "${var.project}"
        environment = "${var.environment}"
    }
}

data "archive_file" "start_lambda" {
    type        = "zip"
    output_path = "${path.module}/archives/start-lambda.zip"

    source {
        content  = "${data.template_file.start_lambda.rendered}"
        filename = "start-lambda.py"
    }
}

resource "aws_lambda_function" "start_lambda" {
    filename = "${path.module}/archives/start-lambda.zip"
    function_name = "ec2-scheduled-start"
    handler = "start-lambda.py"
    role = "${data.terraform_remote_state.iam.start_stop_role_arn}"
    description = "Turns on EC2 instances that match the specified tag values"
    runtime = "python3.6"
    source_code_hash = "${data.archive_file.start_lambda.output_base64sha256}"
    tags {
        Name = "EC2 Scheduled Start"
        Project = "${var.project}"
        Purpose = "Starts EC2 instances that match the specified tags"
        Creator = "${var.creator}"
        Environment = "${var.environment}"
        Freetext = "${var.freetext}"
    }
}

data "template_file" "stop_lambda" {
    template = "${file("${path.module}/stop-lambda.py.template")}"
    vars {
        project = "${var.project}"
        environment = "${var.environment}"
    }
}

data "archive_file" "stop_lambda" {
    type        = "zip"
    output_path = "${path.module}/archives/stop-lambda.zip"

    source {
        content  = "${data.template_file.stop_lambda.rendered}"
        filename = "stop-lambda.py"
    }
}

resource "aws_lambda_function" "stop_lambda" {
    filename = "${path.module}/archives/stop-lambda.zip"
    function_name = "ec2-scheduled-stop"
    handler = "stop-lambda.py"
    role = "${data.terraform_remote_state.iam.start_stop_role_arn}"
    description = "Turns off EC2 instances that match the specified tag values"
    runtime = "python3.6"
    source_code_hash = "${data.archive_file.stop_lambda.output_base64sha256}"
    tags {
        Name = "EC2 Scheduled Stop"
        Project = "${var.project}"
        Purpose = "Stops EC2 instances that match the specified tags"
        Creator = "${var.creator}"
        Environment = "${var.environment}"
        Freetext = "${var.freetext}"
    }
}
