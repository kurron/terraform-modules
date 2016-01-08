variable "vpc_id" {
    description = "If this rule is to be applied to a VPC, the id of the VPC to attach to"
}

variable "ingress_cidr" { 
    description = "A list of CIDR blocks to allow traffic from."
    default = "0.0.0.0/0"
}

variable "egress_cidr" { 
    description = "A list of CIDR blocks to allow traffic to."
    default = "0.0.0.0/0" 
}

variable "name" {
    description = "The name of this security group."
    default = "wide-open"
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
