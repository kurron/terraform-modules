#!/bin/bash

GET="terraform get -update=true ../../../modules/networking/security-groups/"
echo ${GET}
${GET}

PLAN="terraform plan -refresh=true -input=false -var-file=security-groups.tfvars ../../../modules/networking/security-groups/"
echo ${PLAN}
${PLAN}
