#!/bin/bash

DESTROY="terraform destroy -refresh=true -input=false -var-file=settings.tfvars ../../../../modules/compute/bastion/"
echo ${DESTROY}
${DESTROY}
