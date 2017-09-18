#!/bin/bash

GET="terraform get -update=true ../../../../modules/networking/vpc/"
echo ${GET}
${GET}

PLAN="terraform plan -refresh=true -input=false -var-file=settings.tfvars -out=proposed-changes.plan ../../../../modules/networking/vpc/"
echo ${PLAN}
${PLAN}
