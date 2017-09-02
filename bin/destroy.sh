#!/bin/bash

# because the container isn't bound to stdin, we can't tell it do destroy or not
#terraform destroy -refresh=true -force $*

DESTROY="terraform destroy -refresh=true -input=false -var-file=development/networking/vpc.tfvars modules/networking/vpc/"
echo ${DESTROY}
${DESTROY}
