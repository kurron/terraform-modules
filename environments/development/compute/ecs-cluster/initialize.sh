#!/bin/bash

INIT="terraform init -backend-config=backend.cfg \
                     ../../../../modules/compute/ecs-cluster/"
echo ${INIT}
${INIT}
