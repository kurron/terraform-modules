#!/bin/bash

# because the container isn't bound to stdin, we can't tell it do destroy or not
terraform destroy -refresh=true -force $*
