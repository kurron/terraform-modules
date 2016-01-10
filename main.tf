provider "aws" {
    region = "${var.aws_region}"
    max_retries = 10
}

module "vpc" {
    source = "aws/vpc"
    aws_region = "${var.aws_region}"
    name = "Example VPC"
    realm = "${var.realm}"
    purpose = "${var.purpose}"
    managed_by = "${var.managed_by}"
}

module "all-ports" {
    source = "aws/security-groups/wide-open"
    vpc_id =  "${module.vpc.id}"
    name = "VPC Wide Open"
    realm = "${var.realm}"
    purpose = "${var.purpose}"
    managed_by = "${var.managed_by}"
}

module "secure-http" {
    source = "aws/security-groups/secure-http"
    vpc_id =  "${module.vpc.id}"
    name = "VPC Secure HTTP"
    realm = "${var.realm}"
    purpose = "${var.purpose}"
    managed_by = "${var.managed_by}"
}

module "insecure-http" {
    source = "aws/security-groups/insecure-http"
    vpc_id =  "${module.vpc.id}"
    name = "VPC Insecure HTTP"
    realm = "${var.realm}"
    purpose = "${var.purpose}"
    managed_by = "${var.managed_by}"
}

module "ssh" {
    source = "aws/security-groups/ssh"
    vpc_id =  "${module.vpc.id}"
    name = "VPC SSH"
    realm = "${var.realm}"
    purpose = "${var.purpose}"
    managed_by = "${var.managed_by}"
}

module "launch-configuration" {
    source = "aws/launch-configuration"
    name = "${var.launch_configuration_name}"
    image_id = "${lookup(var.aws_amis, var.aws_region)}"
    key_name = "BOB"
}

module "scaling-group" {
    source = "aws/auto-scaling"
    zone_ids = "${split(",", module.vpc.public_subnet_ids)}"
    launch_configuration_name = "${var.launch_configuration_name}"
    name = "Work Hours Only"
    realm = "${var.realm}"
    purpose = "${var.purpose}"
    managed_by = "${var.managed_by}"
}

module "load-balancer" {
    source = "aws/load-balancers/web"
    subnets = "${split(",", module.vpc.public_subnet_ids)}"
    certificate_id = "BOB"
    name = "web-balancer"
    realm = "${var.realm}"
    purpose = "${var.purpose}"
    managed_by = "${var.managed_by}"
}

module "cluster" {
    source = "aws/container-service/cluster"
    name = "container-cluster"
}

module "task" {
    source = "aws/container-service/task"
    family = "example-containers"
    definition = "${file("task-definitions/example.json")}"
}

module "balanced-service" {
    source = "aws/container-service/balanced-service"
    name = "Balanced Service"
    role = "some IAM role"
    desired_count = "1"
    task = "${module.task.id}"
    elb = "${module.load-balancer.name}"
    cluster = "${module.cluster.id}"
    container_name = "SOME CONTAINER NAME"
    container_port = "80"
}

module "unbalanced-service" {
    source = "aws/container-service/unbalanced-service"
    name = "Unbalanced Service"
    desired_count = "1"
    task = "${module.task.id}"
    cluster = "${module.cluster.id}"
}

module "repository" {
    source = "aws/container-service/repository"
    name = "Docker Registry"
    policy = "${file("policies/repository.json")}"
}
