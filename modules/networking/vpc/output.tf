output "vpc_id" {
    value = "${aws_vpc.main.id}"
    description = "ID of the generated VPC"
}

output "vpc_cidr" {
    value = "${aws_vpc.main.cidr_block}"
    description = "The VPC's network range expressed in CIDR notation"
}

output "vpc_main_route_table_id" {
    value = "${aws_vpc.main.main_route_table_id}"
    description = "ID of the VPC's main route table"
}

output "vpc_default_network_acl_id" {
    value = "${aws_vpc.main.default_network_acl_id}"
    description = "ID of the VPC's default network ACL"
}

output "vpc_default_security_group_id" {
    value = "${aws_vpc.main.default_security_group_id}"
    description = "ID of the VPC's default security group"
}

output "vpc_default_route_table_id" {
    value = "${aws_vpc.main.default_route_table_id}"
    description = "ID of the VPC's default route table"
}
