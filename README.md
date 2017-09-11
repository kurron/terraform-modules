# Overview
This project is a library of [Terraform](http://terraform.io/) modules. Inspired by
[The Segment AWS Stack](https://github.com/segmentio/stack).  It is designed
to be used by an Operations team where peer reviews of changes are the norm.

# Prerequisites
* a working [Terraform](http://terraform.io) installation
* an AWS API Key that grants enough rights to create the assets
* the key exported into the environment in a Terraform format
    * `export TF_VAR_aws_access_key=your-key-id`
    * `export TF_VAR_aws_secret_key=your-key-secret`

# Building
There is nothing to build.

# Installation
There is nothing to install per se but there is a bit of set up required to
use the modules as intended.

## Directory Structure
It is recommended that you break up your configurations into folders that
describe the intended context of the resources, e.g. development or production.
Within each of these context folders, you break up the configurations by aspects
that are likely to change at different rates.  For example,

```
├── development
│   ├── compute
│   │   ├── bastion
│   │   └── ecs-cluster
│   ├── networking
│   │   ├── security-groups
│   │   └── vpc
│   └── security
│       └── iam
├── test
│   ├── compute
│   │   ├── bastion
│   │   └── ecs-cluster
│   ├── networking
│   │   ├── security-groups
│   │   └── vpc
│   └── security
│       └── iam
├── production
│   ├── compute
│   │   ├── bastion
│   │   └── ecs-cluster
│   ├── networking
│   │   ├── security-groups
│   │   └── vpc
│   └── security
│       └── iam
```

## Directory Contents
Within each sub-directory, we have the same set of configuration and Bash
scripts.

```
apply.sh
backend.cfg
destroy.sh
initialize.sh
inspect.sh
plan.sh
settings.tfvars
```
The `backend.cfg` file describes where in S3 you want to keep track of your
AWS inventory.  It is recommended that the key name reflect the directory
structure used to separate configurations,
e.g. `development/compute/ecs-cluster/terraform.tfstate`.

The `settings.tfvars` contains the values required by the Terraform module and
will vary depending on the module being referenced. Here is an example:

```
region                      = "us-west-2"

vpc_region                  = "us-east-1"
vpc_bucket                  = "transparent-terraform-state"
vpc_key                     = "development/networking/vpc/terraform.tfstate"
name                        = "Experiment"

project                     = "Weapon-X"
creator                     = "logan@example.com"
environment                 = "development"
freetext                    = "No notes at this time"

bastion_ingress_cidr_blocks = ["64.222.174.146/32","98.216.147.13/32"]
```

The Bash files are convenience scripts designed to help you work through a
typical workflow.

## First Time Set Up
The first time you checkout out the scripts, you will need to go into each
directory and execute the following sequence:

1. `./initialize.sh`
1. `./plan.sh`

This will install the required modules, via soft-linking, and generate a
plan file: `proposed-changes.plan`.  This is a binary file that should be
tracked under source control as it is used in the peer review process.

## Peer Review
Once a plan file has been created and made available for review, you use
the `./inspect.sh` script to generate a human readable set of proposed
changes.  Here is an example where to new security group rules have
been proposed.

```
+ aws_security_group_rule.ec2_egress
    cidr_blocks.#:            "1"
    cidr_blocks.0:            "0.0.0.0/0"
    from_port:                "0"
    protocol:                 "-1"
    security_group_id:        "${aws_security_group.ec2_access.id}"
    self:                     "false"
    source_security_group_id: "<computed>"
    to_port:                  "65535"
    type:                     "egress"

+ aws_security_group_rule.ec2_ingress
    from_port:                "0"
    protocol:                 "-1"
    security_group_id:        "${aws_security_group.ec2_access.id}"
    self:                     "false"
    source_security_group_id: "${aws_security_group.bastion_access.id}"
    to_port:                  "65535"
    type:                     "ingress"
```

Once the changes have been reviewed, approved and merged into the main
branch, they can be executed.

## Applying The Changes
Execute `./apply.sh` to realize the proposed changes, altering actual
AWS resources as needed.

## Destroying Resources
Destruction of

# Tips and Tricks
TODO

# Troubleshooting
TODO

# License and Credits
This project is licensed under the [Apache License Version 2.0, January 2004](http://www.apache.org/licenses/).

# List of Changes
