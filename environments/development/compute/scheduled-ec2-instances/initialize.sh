#!/bin/bash

INIT="terraform init -backend-config=backend.cfg \
                     ../../../../modules/compute/scheduled-ec2-instances/"
echo ${INIT}
${INIT}
