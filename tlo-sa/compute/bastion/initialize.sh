#!/bin/bash

INIT="terraform init -backend-config=backend.cfg \
                     ../../../modules/compute/bastion/"
echo ${INIT}
${INIT}
