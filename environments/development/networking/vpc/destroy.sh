#!/bin/bash

DESTROY="terraform destroy -refresh=true -input=false -var-file=settings.tfvars ../../../../modules/networking/vpc/"
echo ${DESTROY}
${DESTROY}
