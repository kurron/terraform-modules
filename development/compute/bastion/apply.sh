#!/bin/bash

APPLY="terraform apply -refresh=true -input=false -var-file=bastion.tfvars ../../../modules/compute/bastion/"
echo ${APPLY}
${APPLY}
