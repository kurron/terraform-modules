output "Security Group ID" {
    value = "${aws_security_group.security_group.id}"
}

output "Security Group Name" {
    value = "${aws_security_group.security_group.name}"
}

output "Security Group Description" {
    value = "${aws_security_group.security_group.description}"
}

output "Security Group Ingress" {
    value = "${aws_security_group.security_group.ingress}"
}

output "Security Group Egress" {
    value = "${aws_security_group.security_group.egress}"
}

