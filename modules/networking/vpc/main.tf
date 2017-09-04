terraform {
    required_version = ">= 0.10.3"
    backend "s3" {}
}

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "${var.region}"
}

data "aws_availability_zones" "available" {
    state = "available"
}

resource "aws_vpc" "main" {
    cidr_block           = "${var.cidr_range}"
    enable_dns_hostnames = true
    tags {
        Name        = "${var.name}"
        Project     = "${var.project}"
        Purpose     = "${var.purpose}"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "${var.freetext}"
    }
}

resource "aws_eip" "nat" {
    count = "${length( var.private_subnets )}"
    vpc   = true
}

resource "aws_internet_gateway" "main" {
    vpc_id = "${aws_vpc.main.id}"
    tags {
        Name        = "${var.name}"
        Project     = "${var.project}"
        Purpose     = "Routes traffic from the internet to the public subnets"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "${var.freetext}"
    }
}

resource "aws_nat_gateway" "main" {
    count         = "${length( var.private_subnets )}"
    allocation_id = "${element( aws_eip.nat.*.id, count.index) }"
    subnet_id     = "${element( aws_subnet.public.*.id, count.index )}"
    depends_on    = ["aws_internet_gateway.main"]
}

resource "aws_subnet" "public" {
    availability_zone       = "${element( data.aws_availability_zones.available.names, count.index )}"
    cidr_block              = "${element( var.public_subnets, count.index )}"
    vpc_id                  = "${aws_vpc.main.id}"
    map_public_ip_on_launch = true
    count                   = "${length( var.public_subnets )}"
    tags {
        Name        = "${var.name} ${format( "Public %02d", count.index+1 )}"
        Project     = "${var.project}"
        Purpose     = "House instances that can be contacted directly from the internet"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "Allows for incoming traffic from the internet"
    }
}

resource "aws_subnet" "private" {
    availability_zone       = "${element( data.aws_availability_zones.available.names, count.index )}"
    cidr_block              = "${element( var.private_subnets, count.index )}"
    vpc_id                  = "${aws_vpc.main.id}"
    map_public_ip_on_launch = false
    count                   = "${length( var.private_subnets )}"
    tags {
        Name        = "${var.name} ${format( "Private %02d", count.index+1 )}"
        Project     = "${var.project}"
        Purpose     = "House instances that shouldn't be contacted directly from the internet"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "Direct connections from the internet are allowed"
    }
}

resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.main.id}"
    tags {
        Name        = "${var.name} Public"
        Project     = "${var.project}"
        Purpose     = "Handles routing of public subnet instances"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "No notes yet."
    }
}

resource "aws_route" "public" {
    route_table_id         = "${aws_route_table.public.id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = "${aws_internet_gateway.main.id}"
}

resource "aws_route_table_association" "public" {
    count          = "${length( var.public_subnets )}"
    subnet_id      = "${element( aws_subnet.public.*.id, count.index )}"
    route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table" "private" {
    count  = "${length( var.private_subnets) }"
    vpc_id = "${aws_vpc.main.id}"
    tags {
        Name        = "Private ${format("internal-%02d", count.index+1 )}"
        Project     = "${var.project}"
        Purpose     = "Handles routing of private subnet instances"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "No notes yet."
    }
}

resource "aws_route" "private" {
    count                  = "${length( compact( var.private_subnets ) )}"
    route_table_id         = "${element( aws_route_table.private.*.id, count.index )}"
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         = "${element( aws_nat_gateway.main.*.id, count.index )}"
}

resource "aws_route_table_association" "private" {
    count          = "${length( var.private_subnets )}"
    subnet_id      = "${element( aws_subnet.private.*.id, count.index) }"
    route_table_id = "${element( aws_route_table.private.*.id, count.index) }"
}
