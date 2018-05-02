#!/bin/bash

ENV=${1:-production}
echo Deploying $ENV
sudo /usr/local/bin/r10k deploy environment ${ENV} -p -v
