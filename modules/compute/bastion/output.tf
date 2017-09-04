output "ami_id" {
    value = "${data.aws_ami.amazon_linux_ami.id}"
    description = "ID of the selected AMI"
}

output "security_group_id" {
    value = "${aws_security_group.ssh_only.id}"
    description = "ID of the SSH security group"
}

output "security_group_name" {
    value = "${aws_security_group.ssh_only.name}"
    description = "Name of the SSH security group"
}
