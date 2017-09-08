#!/bin/bash

DESTROY="terraform destroy -refresh=true -input=false -var-file=security-groups.tfvars ../../../modules/networking/security-groups/"
echo ${DESTROY}
${DESTROY}
