#!/bin/bash
#
# Written by: Matthias Crauwels <matthias.crauwels@UGent.be>
# Date: August 4th 2017
#
# This script uses pt-config-diff from Percona Toolkit to check the configuration of
# the running MySQL instance to the configuration file on disk.
#
# This file is managed with Puppet!

PT_CONFIG_DIFF=`which pt-config-diff`

# TODO: parameterize these settings...
PERCONA_TOOLKIT_CONFIG="/etc/nagios/mysql.conf"
MYSQL_CONFIG_FILE='/etc/mysql/my.cnf'
HOSTNAME='127.0.0.1'
VARIABLES_TO_IGNORE='read_only,super_read_only,innodb_max_dirty_pages_pct'

# OTHER SETTINGS
CHECK_NAME='MYSQL_CONFIG'

OUTPUT=$(${PT_CONFIG_DIFF} --config=${PERCONA_TOOLKIT_CONFIG} --ignore-variables=${VARIABLES_TO_IGNORE} ${MYSQL_CONFIG_FILE} h=${HOSTNAME} 2>&1)

if [ $? -eq 0 ]
then
  echo "${CHECK_NAME} OK - configuration in configfile and running instance match."
  exit 0
fi

if [ $? -eq 255 ] || [ $? -eq 2 ]
then
  echo "${CHECK_NAME} UNKNOWN - ${OUTPUT}"
  exit 3
fi

echo "${CHECK_NAME} WARNING - ${OUTPUT}"
exit 1
