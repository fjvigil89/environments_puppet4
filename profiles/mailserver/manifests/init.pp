# == Class: mailserver
#
# Full description of class mailserver here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Examples
#
#  class { mailserver:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class mailserver (
  Enum['mx', 'email'] $application_type = 'email',
) {
#anchor { "${module_name}::begin": } ->
#class {"${module_name}::install": } ->
#class {"${module_name}::config": } ~>
#class {"${module_name}::service": } ~>
#class {"${module_name}::params":}~>
#anchor { "${module_name}::end": }

  class { 'postfix':
    config_file_template => "postfix/${::operatingsystem}/etc/postfix/main.cf.erb",
    config_file_hash     => {
    'postfix' => {
      config_file_path   => '/etc/postfix',
      config_file_string => "${::fqdn}\n",
    },
  },
    package_ensure       => 'present',
    config_dir_purge     => true,
    case ${application_type}{
      'mx':{
      config_dir_source => 'puppet:///postfix/Ubuntu/mx',
    }
      'email':{
      config_dir_source =>  'puppet:///postfix/Ubuntu/email',
    }
    }
  }

}

