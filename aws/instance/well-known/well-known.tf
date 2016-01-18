# ------------ inputs ----------------------

variable "name" {
    description = "The name of instance."
}

variable "realm" {
    description = "The logical group that this infrastructure belongs to. Similar idea to an AWS stack."
}

variable "purpose" {
    description = "A tag indicating why all the infrastructure exists, eg. load-testing."
}

variable "managed_by" {
    description = "The tool that manages this resource."
}

variable "image_id" {
    description = "The EC2 image ID to launch."
}

variable "instance_type" {
    description = "The size of instance to launch."
}

variable "instance_profile" {
    description = "The IAM instance profile to associate with launched instances."
    default = ""
}

variable "key_name" {
    description = "The key name that should be used for the instance."
}

variable "security_groups" {
    description = "A list of associated security group IDs."
}

variable "associate_public_ip" {
    description = "Associate a public ip address with an instance in a VPC."
    default = "true"
}

variable "user_data" {
    description = "The path to a file containing the EC2 user data"
}

variable "ebs_optimized" {
    description = "If true, the launched EC2 instance will be EBS-optimized."
    default = "true"
}

variable "enable_monitoring" {
    description = "Enables/disables detailed monitoring."
    default = "true"
}

variable "private_ip" {
    description = "What private ip address to use."
}

variable "subnet_id" {
    description = "What subnet to launch into."
}

# ------------ resources ----------------------

resource "aws_instance" "instance" {
    ami = "${var.image_id}"
    ebs_optimized = "${var.ebs_optimized}"
    disable_api_termination = false
    instance_initiated_shutdown_behavior = "stop"

    instance_type = "${var.instance_type}"
    key_name = "${var.key_name}"
    monitoring = "${var.enable_monitoring}"
    vpc_security_group_ids = ["${var.security_groups}"]
    subnet_id = "${var.subnet_id}"
    associate_public_ip_address = "${var.associate_public_ip}"
    private_ip ="${var.private_ip}"
    source_dest_check = true
    user_data = "${file( var.user_data )}"

    tags {
        Name = "${var.name}"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.managed_by}"
    }
}

# ------------ outputs ----------------------

output "id" {
    value = "${aws_instance.instance.id}"
}

output "az" {
    value = "${aws_instance.instance.availability_zone}"
}

output "key" {
    value = "${aws_instance.instance.key_name}"
}

output "public_dns" {
    value = "${aws_instance.instance.public_dns}"
}

output "public_ip" {
    value = "${aws_instance.instance.public_ip}"
}

output "private_dns" {
    value = "${aws_instance.instance.private_dns}"
}

output "private_ip" {
    value = "${aws_instance.instance.private_ip}"
}

output "security_groups" {
    value = "${aws_instance.instance.vpc_security_group_ids}"
}

output "subnet" {
    value = "${aws_instance.instance.subnet_id}"
}

