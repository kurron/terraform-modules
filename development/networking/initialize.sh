#!/bin/bash

INIT="terraform init -backend-config='bucket=transparent-terraform-state' \
                     -backend-config='key=development/networking/vpc' \
                     -backend-config='region=us-east-1' \
                     ../../modules/networking/vpc/"
echo ${INIT}
${INIT}
