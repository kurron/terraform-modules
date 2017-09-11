#source = "git::git@github.com:foo/modules.git//frontend-app?ref=v0.0.3"

region                      = "us-west-2"

vpc_bucket                  = "transparent-terraform-state"
vpc_key                     = "tlo-sa/networking/vpc/terraform.tfstate"
vpc_region                  = "us-east-1"
security_groups_bucket      = "transparent-terraform-state"
security_groups_key         = "tlo-sa/networking/security-groups/terraform.tfstate"
security_groups_region      = "us-east-1"

project                     = "TLO SA"
creator                     = "rkurr@transparent.com"
environment                 = "development"
freetext                    = "No notes at this time"

instance_type               = "t2.micro"
ssh_key_name                = "asgard-lite-test"
volume_size                 = "32"
ami_list                    = ["ami-8f39c8f7","ami-773fce0f","ami-b33dcccb","ami-d63ecfae","ami-2c21d054","ami-4223d23a","ami-b521d0cd"]
instance_names              = ["Alpha","Bravo","Charlie","Delta","Echo","Foxtrot","Gulf"]
