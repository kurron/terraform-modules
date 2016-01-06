#!/bin/bash

terraform get -update=true
terraform plan -refresh=true -input=true -module-depth=-1 $*
