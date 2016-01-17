# ------------ input -------------------
variable "aws_region" {
    description = "AWS region to launch servers."
    default = "us-west-2"
}

# ------------ resources -------------------
provider "aws" {
    region = "${var.aws_region}"
    max_retries = 10
}

module "ec2_role" {
    source = "../aws/iam/role"
    name = "ec2-instance-role"
    policy_path = "policies/allow-role-assumption.json"
}

