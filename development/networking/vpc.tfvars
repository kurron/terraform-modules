#source = "git::git@github.com:foo/modules.git//frontend-app?ref=v0.0.3"
source = "modules/networking/vpc"

region = "us-west-2"
public_subnets = ["10.0.2.0/24", "10.0.4.0/24"]
private_subnets = ["10.0.1.0/24", "10.0.3.0/24"]
