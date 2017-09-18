#!/bin/bash

GET="terraform get -update=true ../../../modules/compute/bastion/"
echo ${GET}
${GET}

PLAN="terraform plan -refresh=true -input=false -var-file=settings.tfvars -out=proposed-changes.plan ../../../modules/compute/bastion/"
echo ${PLAN}
${PLAN}
