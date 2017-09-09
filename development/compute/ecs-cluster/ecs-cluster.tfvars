#source = "git::git@github.com:foo/modules.git//frontend-app?ref=v0.0.3"

region        = "us-west-2"

vpc_bucket             = "transparent-terraform-state"
vpc_key                = "development/networking/vpc/terraform.tfstate"
vpc_region             = "us-east-1"

iam_bucket             = "transparent-terraform-state"
iam_key                = "development/security/iam/terraform.tfstate"
iam_region             = "us-east-1"

security_groups_bucket = "transparent-terraform-state"
security_groups_key    = "development/networking/security-groups/terraform.tfstate"
security_groups_region = "us-east-1"

project                = "Weapon-X"
creator                = "sampson@example.com"
environment            = "development"
freetext               = "No notes at this time"

ssh_key_name                     = "asgard-lite-test"
cluster_name                     = "Weapon-X"
instance_type                    = "m4.large"
spot_price                       = "0.10"
ebs_optimized                    = false
spot_min_size                    = "1"
spot_max_size                    = "4"
spot_desired_capacity            = "2"
spot_scale_up_cron               = "0 12 * * *"
spot_scale_down_cron             = "0 0 * * *"
spot_scale_down_min_size         = "0"
spot_scale_down_desired_capacity = "0"
cooldown                         = "60"
health_check_grace_period        = "300"
