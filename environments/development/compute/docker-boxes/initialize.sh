#!/bin/bash

INIT="terraform init -backend-config=backend.cfg \
                     ../../../../modules/compute/docker-boxes/"
echo ${INIT}
${INIT}
