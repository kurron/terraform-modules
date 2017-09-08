#!/bin/bash

DESTROY="terraform destroy -refresh=true -input=false -var-file=iam.tfvars ../../../modules/security/iam/"
echo ${DESTROY}
${DESTROY}
