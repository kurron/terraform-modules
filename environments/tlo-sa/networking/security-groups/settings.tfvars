#source = "git::git@github.com:foo/modules.git//frontend-app?ref=v0.0.3"

region                      = "us-west-2"

vpc_region                  = "us-east-1"
vpc_bucket                  = "transparent-test-terraform-state"
vpc_key                     = "tlo-sa/networking/vpc/terraform.tfstate"
name                        = "Experiment"

project                     = "TLO SA"
creator                     = "rkurr@transparent.com"
environment                 = "development"
freetext                    = "No notes at this time"

bastion_ingress_cidr_blocks = ["64.222.174.146/32","98.216.147.13/32"]
