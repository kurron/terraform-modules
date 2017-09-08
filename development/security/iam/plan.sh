#!/bin/bash

GET="terraform get -update=true ../../../modules/security/iam/"
echo ${GET}
${GET}

PLAN="terraform plan -refresh=true -input=false -var-file=iam.tfvars -out=proposed-changes.plan ../../../modules/security/iam/"
echo ${PLAN}
${PLAN}
