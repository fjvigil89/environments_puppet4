#!/bin/bash

ENV=${1:-production}
echo Deploying $ENV
ssh -t root@puppet-master.upr.edu.cu "cd /opt/puppetlabs/puppet/bin/r10k deploy environment ${ENV} -p -v"
