#!/bin/bash

INIT="terraform init -backend-config=backend.cfg \
                     ../../../../modules/compute/dynamic-dns/"
echo ${INIT}
${INIT}
