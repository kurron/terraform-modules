output "ami_id" {
    value = "${data.aws_ami.amazon_linux_ami.id}"
    description = "ID of the selected AMI"
}
