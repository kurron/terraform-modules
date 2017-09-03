#!/bin/bash

DESTROY="terraform destroy -refresh=true -input=false -var-file=vpc.tfvars ../../modules/networking/vpc/"
echo ${DESTROY}
${DESTROY}
