#!/bin/bash

GET="terraform get -update=true ../../../modules/compute/docker-boxes/"
echo ${GET}
${GET}

PLAN="terraform plan -refresh=true -input=false -var-file=settings.tfvars -out=proposed-changes.plan ../../../modules/compute/docker-boxes/"
echo ${PLAN}
${PLAN}
