#!/bin/bash

DESTROY="terraform destroy -refresh=true -input=false -var-file=settings.tfvars ../../../../modules/management/dynamic-dns/"
echo ${DESTROY}
${DESTROY}
