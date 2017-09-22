#source = "git::git@github.com:foo/modules.git//frontend-app?ref=v0.0.3"

region                 = "us-west-2"

iam_bucket             = "transparent-test-terraform-state"
iam_key                = "development/security/iam/terraform.tfstate"
iam_region             = "us-east-1"

lambda_bucket             = "transparent-test-terraform-state"
lambda_key                = "development/compute/scheduled-ec2-instances/terraform.tfstate"
lambda_region             = "us-east-1"

project                = "Weapon-X"
creator                = "rkurr@transparent.com"
environment            = "development"
freetext               = "No notes at this time"

start_cron_expression = "rate(5 minutes)"
