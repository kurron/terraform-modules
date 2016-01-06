resource "aws_vpc" "main" {
    cidr_block = "${var.cidr_block}"
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
