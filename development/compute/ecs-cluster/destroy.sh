#!/bin/bash

DESTROY="terraform destroy -refresh=true -input=false -var-file=ecs-cluster.tfvars ../../../modules/compute/ecs-cluster/"
echo ${DESTROY}
${DESTROY}
