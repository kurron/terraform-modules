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

    ingress {
        from_port = 22
        to_port = 22
        protocol = "-1"
        cidr_blocks = ["${element(split(",", var.ingress_cidr), count.index)}"]
    }
}
