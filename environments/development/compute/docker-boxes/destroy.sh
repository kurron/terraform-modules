#!/bin/bash

DESTROY="terraform destroy -refresh=true -input=false -var-file=settings.tfvars ../../../../modules/compute/docker-boxes/"
echo ${DESTROY}
${DESTROY}
