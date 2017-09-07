#source = "git::git@github.com:foo/modules.git//frontend-app?ref=v0.0.3"

region          = "us-west-2"
cidr_range      = "10.0.0.0/16"
name            = "Experiment"
project         = "Weapon-X"
purpose         = "Separate network for experimentation"
creator         = "nobody@example.com"
environment     = "development"
freetext        = "No notes at this time"
public_subnets  = ["10.0.2.0/24", "10.0.4.0/24"]
private_subnets = ["10.0.1.0/24", "10.0.3.0/24"]
