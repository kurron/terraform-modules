#!/bin/bash

APPLY="terraform apply -refresh=true -input=false -var-file=security-groups.tfvars ../../../modules/networking/security-groups/"
echo ${APPLY}
${APPLY}
