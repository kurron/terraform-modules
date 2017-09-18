#!/bin/bash

DESTROY="terraform destroy -refresh=true -input=false -var-file=settings.tfvars ../../../../modules/security/iam/"
echo ${DESTROY}
${DESTROY}
