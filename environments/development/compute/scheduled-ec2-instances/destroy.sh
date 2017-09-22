#!/bin/bash

DESTROY="terraform destroy -refresh=true -input=false -var-file=settings.tfvars ../../../../modules/compute/scheduled-ec2-instances/"
echo ${DESTROY}
${DESTROY}
