#!/bin/bash

ENV=${1:-production}
echo Deploying $ENV
sudo /opt/puppetlabs/puppet/bin/r10k deploy environment ${ENV} -p -v
