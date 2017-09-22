#!/bin/bash

INIT="terraform init -backend-config=backend.cfg \
                     ../../../../modules/management/ec2-schedule/"
echo ${INIT}
${INIT}
