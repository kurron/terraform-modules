#!/bin/bash

DESTROY="terraform destroy -refresh=true -input=false -var-file=settings.tfvars ../../../../modules/management/ec2-schedule/"
echo ${DESTROY}
${DESTROY}
