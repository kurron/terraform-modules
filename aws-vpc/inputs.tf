variable "aws_region" {
    description = "AWS region to launch servers."
    default = "us-west-2"
}

variable "cidr_block" {
    description = "The class B network to create, in CIDR notation."
    default = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  description = "TODO"
  default = true
}

variable "instance_tenancy" {
  description = "How EC2 instances should be combined or separated from other instances"
  default = "default"
}

variable "name" {
    description = "The name of this VPC."
    default = "Primary VPC"
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
