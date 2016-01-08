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

output "default_acl" {
    value = "${aws_vpc.main.default_network_acl_id}"
}

output "default_security_group" {
    value = "${aws_vpc.main.default_security_group_id}"
}
