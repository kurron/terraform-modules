#!/bin/bash

GET="terraform get -update=true ../../../../modules/compute/scheduled-ec2-instances/"
echo ${GET}
${GET}

PLAN="terraform plan -refresh=true -input=false -var-file=settings.tfvars -out=proposed-changes.plan ../../../../modules/compute/scheduled-ec2-instances/"
echo ${PLAN}
${PLAN}
