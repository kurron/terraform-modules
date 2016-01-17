# ------------ input -------------------
variable "aws_region" {
    description = "AWS region to launch servers."
    default = "us-west-2"
}

variable "cidr_block" {
    description = "VPC's network"
    default = "10.0.0.0/16"
}

variable "subnets" {
    description = "Subnets inside the VPC"
    default = "10.0.10.0/24,10.0.30.0/24,10.0.50.0/24" 
}

variable "availability_zones" {
    description = "Availability zones to put networks into"
    default = {
        us-east-1 = "us-east-1a,us-east-1b,us-east-1c"
        us-west-1 = "us-west-1a,us-west-1b,us-west-1c"
        us-west-2 = "us-west-2a,us-west-2b,us-west-2c"
    }
}

variable "realm" {
    description = "The logical group that all of the infrastructure belongs to. Similar idea to an AWS stack."
    default = "module-experimentation" 
}

variable "purpose" {
    description = "A tag indicating why all the infrastructure exists, eg. load-testing."
    default = "Terraforming" 
}

variable "managed_by" {
    description = "The tool that manages this resource."
    default = "Terraform" 
}

variable "launch_configuration_name" {
    description = "The name of the launch configuration."
    default = "micro-instance" 
}

variable "key_name" {
    description = "The name of the SSH key to use."
    default = "asgard-lite-test" 
}

variable "server_user_data" {
    description = "The path to the file containing the EC2 user data."
    default = "user-data/touch.txt" 
}

# Ubuntu Server 14.04 LTS (HVM), SSD Volume Type, 64-bit
variable "aws_amis" {
    description = "AMI to build the instances from."
    default = {
        us-east-1      = "ami-81ea1aea"
        us-west-1      = "ami-df6a8b9b"
        us-west-2      = "ami-5189a661"
        eu-west-1      = "ami-47a23a30"
        eu-central-1   = "ami-accff2b1"
        sa-east-1      = "ami-4d883350"
        ap-southeast-1 = "ami-96f1c1c4"
        ap-southeast-2 = "ami-69631053"
        ap-northeast-1 = "ami-936d9d93"
    }
}

variable "ec2_instance_role_name" {
    default = "ec2-instances-role" 
}

# ------------ resources -------------------
provider "aws" {
    region = "${var.aws_region}"
    max_retries = 10
}

module "vpc" {
    source = "aws/vpc"
    aws_region = "${var.aws_region}"
    name = "Example VPC"
    cidr_block = "${var.cidr_block}"
    subnets = "${var.subnets}"
    availability_zones = "${lookup(var.availability_zones, var.aws_region)}"
    realm = "${var.realm}"
    purpose = "${var.purpose}"
    managed_by = "${var.managed_by}"
}

module "null_security_group" {
    source = "aws/security-groups/wide-open"
    vpc_id =  "${module.vpc.id}"
    name = "Null Security Group"
    realm = "${var.realm}"
    purpose = "${var.purpose}"
    managed_by = "${var.managed_by}"
}

module "role_assumption_policy" {
    source = "aws/iam/policy"
    name = "ec2-role-assumption"
    description = "Allows EC2 instances to assume roles."
    policy_path = "policies/ec2-role-assumption.json"
}

module "ec2_role" {
    source = "aws/iam/role"
    name = "${var.ec2_instance_role_name}"
    policy_path = "policies/allow-role-assumption.json"
}

module "ec2_instance_profile" {
    source = "aws/iam/instance-profile"
    name = "ec2-instances-profile"
    roles = "${var.ec2_instance_role_name}"
}

module "scheduled_launch_configuration" {
    source = "aws/launch-configuration"
    name = "${var.launch_configuration_name}"
    image_id = "${lookup(var.aws_amis, var.aws_region)}"
    instance_type = "t2.nano"
    instance_profile = "${module.ec2_instance_profile.id}"
    key_name = "${var.key_name}"
    security_groups = "${module.null_security_group.id}"
    ebs_optimized = false
    user_data = "${file( var.server_user_data )}" 
}

module "scheduled_scaling_group" {
    source = "aws/auto-scaling/scheduled"
    name = "Work Hours Only"
    realm = "${var.realm}"
    purpose = "${var.purpose}"
    managed_by = "${var.managed_by}"
    max_size = 6
    min_size = 1
    desired_capacity = 3

    up_name = "Spin-Up Schedule"
    up_min_size = 1 
    up_max_size = 6 
    up_desired_capacity = 3

    down_name = "Spin-Down Schedule"
    down_min_size = 0 
    down_max_size = 1 
    down_desired_capacity = 0

    subnet_ids = "${split(",", module.vpc.subnet_ids)}"
    launch_configuration_name = "${var.launch_configuration_name}"
}

