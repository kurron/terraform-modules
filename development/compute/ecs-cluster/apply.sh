#!/bin/bash

APPLY="terraform apply -refresh=true -input=false -var-file=ecs-cluster.tfvars ../../../modules/compute/ecs-cluster/"
echo ${APPLY}
${APPLY}
