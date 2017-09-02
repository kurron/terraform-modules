#source = "git::git@github.com:foo/modules.git//frontend-app?ref=v0.0.3"
source = "../../modules/networking/vpc"

aws_region = "us-west-2"
environment_name = "prod"
frontend_app_instance_type = "m4.large"
frontend_app_instance_count = 10
