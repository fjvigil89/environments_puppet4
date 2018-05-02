#!/usr/bin/env bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/tools/functions"
if [ "x${1}" == "xfix" ]; then
  PUPPETLINT='puppet-lint -f'
else
  PUPPETLINT='puppet-lint'
fi
global_exit=0

if [ ! -z $(which puppet-lint) ]; then
  echo_title "Puppet linting manifests in site and manifests directory"

  for i in $(find site manifests -name '*.pp' | grep -v fixtures)
  do
    echo -ne "$i - "
    $PUPPETLINT $i
    if [ $? == 0 ]; then
      echo_success "OK"
    else
      echo_failure "ERROR"
      global_exit=1
    fi
  done
else
  echo_warning "puppet-lint command not found"
fi

exit $global_exit


