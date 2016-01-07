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

variable "public_subnets" { 
    description = "A list of subnets that can be accessed via the internet."
    default = "10.0.10.0/24,10.0.30.0/24,10.0.50.0/24" 
}

variable "private_subnets" { 
    description = "A list of subnets that cannot be accessed via the internet."
    default = "10.0.20.0/24,10.0.40.0/24,10.0.60.0/24"
}

variable "availability_zones" { 
    description = "A list of availability zones we want to be in."
    default = "us-west-2a,us-west-2b,us-west-2c"
}

variable "subnet_name" {
    default = {
        "0" = "Alpha"
        "1" = "Bravo"
        "2" = "Charlie"
        "3" = "Delta"
        "4" = "Echo"
        "5" = "Foxtrot"
        "6" = "Golf"
        "7" = "Hotel"
    }
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
