#!/bin/bash

#terraform get -update=true
#terraform plan -refresh=true -input=true -module-depth=-1 $*

GET="terraform get -update=true modules/networking/vpc/"
echo ${GET}
${GET}

PLAN="terraform plan -refresh=true -input=false -var-file=development/networking/vpc.tfvars modules/networking/vpc/"
echo ${PLAN}
${PLAN}
