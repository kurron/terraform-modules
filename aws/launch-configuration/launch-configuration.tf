# ------------ inputs ----------------------

variable "name" {
    description = "The name of the launch configuration."
}

variable "image_id" {
    description = "The EC2 image ID to launch."
}

variable "instance_type" {
    description = "The size of instance to launch."
}

variable "instance_profile" {
    description = "The IAM instance profile to associate with launched instances."
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
    default = ""
}

variable "ebs_optimized" {
    description = "If true, the launched EC2 instance will be EBS-optimized."
    default = "true"
}

variable "spot_price" {
    description = "The price to use for reserving spot instances."
    default = ""
}

variable "enable_monitoring" {
    description = "Enables/disables detailed monitoring."
    default = "true"
}
# ------------ resources ----------------------

resource "aws_launch_configuration" "alc" {
    name = "${var.name}"
    image_id = "${var.image_id}"
    instance_type = "${var.instance_type}"
    iam_instance_profile = "${var.instance_profile}"
    key_name = "${var.key_name}"
    security_groups = ["${split(",", var.security_groups)}"]
    associate_public_ip_address = "${var.associate_public_ip}"
    user_data = "${var.user_data}"
    enable_monitoring = "${var.enable_monitoring}"
    ebs_optimized = "${var.ebs_optimized}"
    spot_price = "${var.spot_price}"
#   root_block_device = ???
#   ebs_block_device = ???
#   ephemeral_block_device = ???

#   lifecycle { create_before_destroy = true }
}

# ------------ outputs ----------------------

output "id" {
    value = "${aws_launch_configuration.alc.id}"
}

