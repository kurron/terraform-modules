#-------------------- inputs -----------------------

variable "aws_region" {
    description = "AWS region to launch servers."
    default = "us-west-2"
}

variable "cidr_block" {
    description = "The class B network to create, in CIDR notation."
    default = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  description = "TODO"
  default = true
}

variable "instance_tenancy" {
  description = "How EC2 instances should be combined or separated from other instances"
  default = "default"
}

variable "public_subnets" { 
    description = "A list of subnets that can be accessed via the internet."
    default = "10.0.10.0/24,10.0.30.0/24,10.0.50.0/24" 
}

variable "private_subnets" { 
    description = "A list of subnets that cannot be accessed via the internet."
    default = "10.0.20.0/24,10.0.40.0/24,10.0.60.0/24"
}

variable "availability_zones" { 
    description = "A list of availability zones we want to be in."
    default = "us-west-2a,us-west-2b,us-west-2c"
}

variable "subnet_name" {
    default = {
        "0" = "Alpha"
        "1" = "Bravo"
        "2" = "Charlie"
        "3" = "Delta"
        "4" = "Echo"
        "5" = "Foxtrot"
        "6" = "Golf"
        "7" = "Hotel"
    }
}

variable "name" {
    description = "The name of this VPC."
    default = "Primary VPC"
}

variable "realm" {
    description = "The logical group that all of the infrastructure belongs to. Similar idea to an AWS stack."
    default = "terraform-experimentation" 
}

variable "purpose" {
    description = "A tag indicating why all the infrastructure exists, eg. load-testing."
    default = "Prototyping" 
}

variable "managed_by" {
    description = "The tool that manages this resource."
    default = "Terraform" 
}

#-------------------- resources -----------------------

resource "aws_vpc" "main" {
    cidr_block = "${var.cidr_block}"
    enable_dns_support = true
    enable_dns_hostnames = "${var.enable_dns_hostnames}"
    instance_tenancy = "${var.instance_tenancy}"

    tags {
        Name = "${var.name}"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.managed_by}"    
    }
}

resource "aws_internet_gateway" "main" {
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "${var.name}"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.managed_by}"    
    }
}

resource "aws_route_table" "main" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main.id}"
    }

    tags {
        Name = "${var.name}"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.managed_by}"    
    }
}

resource "aws_main_route_table_association" "main" {
    vpc_id = "${aws_vpc.main.id}"
    route_table_id = "${aws_route_table.main.id}"
}

resource "aws_subnet" "private" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${element(split(",", var.private_subnets), count.index)}"
    availability_zone = "${element(split(",", var.availability_zones), count.index)}"
    count = "${length(compact(split(",", var.private_subnets)))}"
    tags {
        Name = "Private ${lookup(var.subnet_name, count.index)}"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.managed_by}"
    }
}

resource "aws_subnet" "public" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${element(split(",", var.public_subnets), count.index)}"
    availability_zone = "${element(split(",", var.availability_zones), count.index)}"
    count = "${length(compact(split(",", var.public_subnets)))}"
    tags {
        Name = "Public ${lookup(var.subnet_name, count.index)}"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.managed_by}"
    }
}

#-------------------- outputs -----------------------

output "id" {
    value = "${aws_vpc.main.id}"
}

output "network" {
    value = "${aws_vpc.main.cidr_block}"
}

output "tenancy" {
    value = "${aws_vpc.main.instance_tenancy}"
}

output "route_table" {
    value = "${aws_vpc.main.main_route_table_id}"
}

output "acl" {
    value = "${aws_vpc.main.default_network_acl_id}"
}

output "security_group" {
    value = "${aws_vpc.main.default_security_group_id}"
}

output "public_subnet_ids" {
    value = "${join(",", aws_subnet.public.*.id)}"
}

output "private_subnet_ids" {
    value = "${join(",", aws_subnet.private.*.id)}"
}
