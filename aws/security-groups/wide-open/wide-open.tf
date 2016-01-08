resource "aws_security_group" "security_group" {
    name = "${var.name}"
    description = "Allow inbound and outbound access on ALL ports."
    vpc_id = "${var.vpc_id}"
    tags {
        Name = "${var.name}"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.managed_by}"    
    }

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["${element(split(",", var.ingress_cidr), count.index)}"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["${element(split(",", var.egress_cidr), count.index)}"]
    }
}
