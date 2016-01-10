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

variable "launch_configuration_name" {
    description = "The name of the launch configuration."
    default = "micro-instance" 
}

# Ubuntu Server 14.04 LTS (HVM), SSD Volume Type, 64-bit
variable "aws_amis" {
    description = "AMI to build the instances from."
    default = {
        us-east-1      = "ami-81ea1aea"
        us-west-1      = "ami-df6a8b9b"
        us-west-2      = "ami-5189a661"
        eu-west-1      = "ami-47a23a30"
        eu-central-1   = "ami-accff2b1"
        sa-east-1      = "ami-4d883350"
        ap-southeast-1 = "ami-96f1c1c4"
        ap-southeast-2 = "ami-69631053"
        ap-northeast-1 = "ami-936d9d93"
    }
}

