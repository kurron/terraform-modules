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

resource "aws_subnet" "public" {
    availability_zone       = "${element( data.aws_availability_zones.available.names, count.index )}"
    cidr_block              = "${element( var.public_subnets, count.index )}"
    vpc_id                  = "${aws_vpc.main.id}"
    map_public_ip_on_launch = true
    count                   = "${length( data.aws_availability_zones.available.names )}"
    tags {
        Name        = "${var.name} ${format( "Public %02d", count.index+1 )}"
        Project     = "${var.project}"
        Purpose     = "To handle any direct connections from the internet"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "Allows for incoming traffic from the internet"
    }
}
