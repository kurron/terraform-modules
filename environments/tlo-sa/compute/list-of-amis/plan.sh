#!/bin/bash

GET="terraform get -update=true ../../../modules/compute/list-of-amis/"
echo ${GET}
${GET}

PLAN="terraform plan -refresh=true -input=false -var-file=settings.tfvars -out=proposed-changes.plan ../../../modules/compute/list-of-amis/"
echo ${PLAN}
${PLAN}
