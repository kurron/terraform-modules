#!/bin/bash

DESTROY="terraform destroy -refresh=true -input=false -var-file=bastion.tfvars ../../../modules/compute/bastion/"
echo ${DESTROY}
${DESTROY}
