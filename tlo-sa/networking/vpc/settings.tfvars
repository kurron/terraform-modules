#source = "git::git@github.com:foo/modules.git//frontend-app?ref=v0.0.3"

region          = "us-west-2"

name            = "TLO SA"
project         = "TLO SA"
purpose         = "Network to test out the TLO SA installers"
creator         = "rkurr@transparent.com"
environment     = "development"
freetext        = "No notes at this time"

cidr_range      = "10.0.0.0/16"
public_subnets  = ["10.0.2.0/24"]
private_subnets = ["10.0.1.0/24"]
