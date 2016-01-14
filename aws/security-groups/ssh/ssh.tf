#-------------- inputs ----------------

variable "vpc_id" {
    description = "If this rule is to be applied to a VPC, the id of the VPC to attach to"
}

variable "ingress_cidr" { 
    description = "A list of CIDR blocks to allow traffic from."
    default = "0.0.0.0/0"
}

variable "name" {
    description = "The name of this security group."
    default = "secure-http"
}

variable "realm" {
    description = "The logical group that all of the infrastructure belongs to. Similar idea to an AWS stack."
    default = "terraform-experimentation" 
}

variable "purpose" {
    description = "A tag indicating why all the infrastructure exists, eg. load-testing."
    default = "Prototyping" 
}

variable "managed_by" {
    description = "The tool that manages this resource."
    default = "Terraform" 
}

#-------------- resources ----------------

resource "aws_security_group" "security_group" {
    name = "${var.name}"
    description = "Allow inbound access over SSH (22)."
    vpc_id = "${var.vpc_id}"
    tags {
        Name = "${var.name}"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.managed_by}"    
    }

    lifecycle { create_before_destroy = true }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${element(split(",", var.ingress_cidr), count.index)}"]
    }
}

#-------------- outputs ----------------

output "id" {
    value = "${aws_security_group.security_group.id}"
}

output "name" {
    value = "${aws_security_group.security_group.name}"
}

output "description" {
    value = "${aws_security_group.security_group.description}"
}

output "ingress" {
    value = "${aws_security_group.security_group.ingress}"
}

output "egress" {
    value = "${aws_security_group.security_group.egress}"
}

