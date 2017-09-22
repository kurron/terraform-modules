#!/bin/bash

GET="terraform get -update=true ../../../../modules/management/ec2-schedule/"
echo ${GET}
${GET}

PLAN="terraform plan -refresh=true -input=false -var-file=settings.tfvars -out=proposed-changes.plan ../../../../modules/management/ec2-schedule/"
echo ${PLAN}
${PLAN}
