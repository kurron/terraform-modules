#!/bin/bash

APPLY="terraform apply -refresh=true -input=false -var-file=vpc.tfvars ../../../modules/networking/vpc/"
echo ${APPLY}
${APPLY}