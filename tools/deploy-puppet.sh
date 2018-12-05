#!/bin/bash

ENV=${1:-production}
echo Deploying $ENV
ssh -i /root/.ssh/id_rsa root@puppet-master.upr.edu.cu "/opt/puppetlabs/puppet/bin/r10k deploy environment $ENV -p -v"
