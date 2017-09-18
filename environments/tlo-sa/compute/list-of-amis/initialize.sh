#!/bin/bash

INIT="terraform init -backend-config=backend.cfg \
                     ../../../modules/compute/list-of-amis/"
echo ${INIT}
${INIT}
