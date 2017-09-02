#!/bin/bash

CMD="terraform apply -refresh=true -input=false -var-file=development/networking/vpc.tfvars modules/networking/vpc/"
echo ${CMD}
${CMD}
