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

instance_type               = "t2.nano"
ssh_key_name                = "asgard-lite-test"
min_size                    = "1"
max_size                    = "2"
cooldown                    = "60"
health_check_grace_period   = "300"
desired_capacity            = "1"
scale_down_desired_capacity = "0"
scale_down_min_size         = "0"
scale_up_cron               = "0 12 * * *"
scale_down_cron             = "0 0 * * *"