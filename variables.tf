variable "aws_region" {
    description = "AWS region to launch servers."
    default = "us-west-2"
}

variable "realm" {
    description = "The logical group that all of the infrastructure belongs to. Similar idea to an AWS stack."
    default = "module-experimentation" 
}

variable "purpose" {
    description = "A tag indicating why all the infrastructure exists, eg. load-testing."
    default = "Terraforming" 
}

variable "managed_by" {
    description = "The tool that manages this resource."
    default = "Terraform" 
}
