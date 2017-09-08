#!/bin/bash

APPLY="terraform apply -refresh=true -input=false proposed-changes.plan"
echo ${APPLY}
${APPLY}
