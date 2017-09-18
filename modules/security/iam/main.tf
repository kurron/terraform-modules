terraform {
    required_version = ">= 0.10.3"
    backend "s3" {}
}

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "${var.region}"
}

data "terraform_remote_state" "vpc" {
    backend = "s3"
    config {
        bucket = "${var.vpc_bucket}"
        key    = "${var.vpc_key}"
        region = "${var.vpc_region}"
    }
}

# construct a role that allows pulling from ECR
resource "aws_iam_role" "cross_account_ecr_pull_role" {
    name_prefix        = "ecr-pull-"
    description        = "Allows EC2 instances to assume required roles"
    assume_role_policy = "${file( "${path.module}/ecr-pull-only-role-policy.json" )}"
}

resource "aws_iam_role_policy" "cross_account_ecr_pull_role_policy" {
    name_prefix = "ecr-pull-"
    role        = "${aws_iam_role.cross_account_ecr_pull_role.id}"
    policy      = "${file("${path.module}/ecr-pull-only-policy.json")}"
}

resource "aws_iam_instance_profile" "cross_account_ecr_pull_profile" {
    name_prefix = "ecr-pull-"
    role  = "${aws_iam_role.cross_account_ecr_pull_role.name}"
}

# construct a role that alloww ECS instances to interact with load balancers
resource "aws_iam_role" "default_ecs_role" {
    name_prefix = "ecs-role"
    description = "Allows ECS workers to assume required roles"
    assume_role_policy = "${file( "${path.module}/default-ecs-role-policy.json" )}"
}

resource "aws_iam_role_policy" "default_ecs_service_role_policy" {
    name_prefix = "ecs-service-role-${var.project}-${var.environment}-"
    role = "${aws_iam_role.default_ecs_role.id}"
    policy = "${file( "${path.module}/default-ecs-service-role-policy.json" )}"
}

resource "aws_iam_role_policy" "default_ecs_instance_role_policy" {
    name_prefix = "ecs-instance-role-policy-${var.project}-${var.environment}-"
    role = "${aws_iam_role.default_ecs_role.id}"
    policy = "${file( "${path.module}/default-ecs-instance-role-policy.json" )}"
}

resource "aws_iam_instance_profile" "default_ecs" {
    name_prefix = "ecs-instance-profile-${var.project}-${var.environment}-"
    role  = "${aws_iam_role.default_ecs_role.name}"
}
