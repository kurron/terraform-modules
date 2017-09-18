#source = "git::git@github.com:foo/modules.git//frontend-app?ref=v0.0.3"

region        = "us-west-2"

vpc_bucket             = "transparent-test-terraform-state"
vpc_key                = "development/networking/vpc/terraform.tfstate"
vpc_region             = "us-east-1"

iam_bucket             = "transparent-test-terraform-state"
iam_key                = "development/security/iam/terraform.tfstate"
iam_region             = "us-east-1"

bastion_bucket         = "transparent-test-terraform-state"
bastion_key            = "development/compute/bastion/terraform.tfstate"
bastion_region         = "us-east-1"

security_groups_bucket = "transparent-test-terraform-state"
security_groups_key    = "development/networking/security-groups/terraform.tfstate"
security_groups_region = "us-east-1"

project                = "Weapon-X"
creator                = "rkurr@transparent.com"
environment            = "development"
freetext               = "No notes at this time"

instance_type                    = "t2.nano"
ebs_optimized                    = false
