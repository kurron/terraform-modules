#!/bin/bash

INIT="terraform init -backend-config=backend.cfg \
                     ../../modules/networking/vpc/"
echo ${INIT}
${INIT}
