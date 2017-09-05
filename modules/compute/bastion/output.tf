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

output "launch_configuration_id" {
    value = "${aws_launch_configuration.bastion.id}"
    description = "ID of the Bastion's launch configuration"
}

output "launch_configuration_name" {
    value = "${aws_launch_configuration.bastion.name}"
    description = "Name of the Bastion's launch configuration"
}

output "auto_scaling_group_id" {
    value = "${aws_autoscaling_group.bastion.id}"
    description = "ID of the Bastion's auto scaling group"
}

output "auto_scaling_group_name" {
    value = "${aws_autoscaling_group.bastion.name}"
    description = "Name of the Bastion's auto scaling group"
}
