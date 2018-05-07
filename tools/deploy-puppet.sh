#!/bin/bash

ENV=${1:-production}
echo Deployingg $ENV
/opt/puppetlabs/puppet/bin/r10k deploy environment ${ENV} -p -v
