#!/bin/bash

DESTROY="terraform destroy -refresh=true -input=false -var-file=settings.tfvars ../../../modules/compute/list-of-amis/"
echo ${DESTROY}
${DESTROY}
