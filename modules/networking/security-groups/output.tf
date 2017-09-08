output "bastion_id" {
    value = "${aws_security_group.bastion_access.id}"
    description = "ID of the Bastion security group"
}

output "bastion_name" {
    value = "${aws_security_group.bastion_access.name}"
    description = "Name of the Bastion security group"
}
