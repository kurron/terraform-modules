#!/bin/bash

INIT="terraform init -backend-config=backend.cfg \
                     ../../../../modules/security/iam/"
echo ${INIT}
${INIT}
