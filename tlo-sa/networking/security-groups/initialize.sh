#!/bin/bash

INIT="terraform init -backend-config=backend.cfg \
                     ../../../modules/networking/security-groups/"
echo ${INIT}
${INIT}
