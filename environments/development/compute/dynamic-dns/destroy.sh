#!/bin/bash

DESTROY="terraform destroy -refresh=true -input=false -var-file=settings.tfvars ../../../../modules/compute/dynamic-dns/"
echo ${DESTROY}
${DESTROY}
