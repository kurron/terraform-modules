#source = "git::git@github.com:foo/modules.git//frontend-app?ref=v0.0.3"

region                      = "us-west-2"

vpc_bucket                  = "transparent-terraform-state"
vpc_key                     = "development/networking/vpc/terraform.tfstate"
vpc_region                  = "us-east-1"

project                     = "Weapon-X"
environment                 = "development"
