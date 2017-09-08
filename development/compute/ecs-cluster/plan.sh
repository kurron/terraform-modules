#!/bin/bash

GET="terraform get -update=true ../../../modules/compute/ecs-cluster/"
echo ${GET}
${GET}

PLAN="terraform plan -refresh=true -input=false -var-file=ecs-cluster.tfvars ../../../modules/compute/ecs-cluster/"
echo ${PLAN}
${PLAN}