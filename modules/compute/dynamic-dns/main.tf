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

data "template_file" "dynamic_dns" {
    template = "${file("${path.module}/union.py.template")}"
    vars {
        project = "${var.project}"
        environment = "${var.environment}"
    }
}

data "archive_file" "dynamic_dns" {
    type        = "zip"
    output_path = "${path.module}/archives/dynamic-dns.zip"

    source {
        content  = "${data.template_file.dynamic_dns.rendered}"
        filename = "union.py"
    }
}

resource "aws_lambda_function" "dynamic_dns" {
    filename = "${path.module}/archives/dynamic-dns.zip"
    function_name = "dynamic-dns"
    handler = "union.lambda_handler"
    role = "${data.terraform_remote_state.iam.dynamic_dns_role_arn}"
    description = "Dynamically registers EC2 instances with Route53"
    runtime = "python2.7"
    source_code_hash = "${data.archive_file.dynamic_dns.output_base64sha256}"
    tags {
        Name = "Dynamic DNS"
        Project = "${var.project}"
        Purpose = "Registers EC2 instances matching specific tags with Route53"
        Creator = "${var.creator}"
        Environment = "${var.environment}"
        Freetext = "${var.freetext}"
    }
}
