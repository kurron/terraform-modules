#!/bin/bash

terraform apply -refresh=true -input=true $*
