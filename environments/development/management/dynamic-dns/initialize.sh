#!/bin/bash

INIT="terraform init -backend-config=backend.cfg \
                     ../../../../modules/management/dynamic-dns/"
echo ${INIT}
${INIT}
