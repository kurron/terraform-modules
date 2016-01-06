output "VPC ID" {
    value = "${aws_vpc.main.id}"
}

output "VPC Network" {
    value = "${aws_vpc.main.cidr_block}"
}

output "VPC Tenancy" {
    value = "${aws_vpc.main.instance_tenancy}"
}

output "VPC Route Table" {
    value = "${aws_vpc.main.main_route_table_id}"
}

output "VPC Default ACL" {
    value = "${aws_vpc.main.default_network_acl_id}"
}

output "VPC Default Security Group" {
    value = "${aws_vpc.main.default_security_group_id}"
}
