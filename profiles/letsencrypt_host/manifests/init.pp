# == Class: letsencrypt_host
#
# Full description of class letsencrypt_host here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'letsencrypt_host':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2018 Your name here, unless otherwise noted.
#
class letsencrypt_host (
# lint:ignore:140chars
  Array[String] $dominios        = $::letsencrypt_host::params::dominios,
  Boolean $webroot_enable        = false,
  Array[String] $webroot_paths   = $::letsencrypt_host::params::webroot_paths,
  String $plugin                 = $::letsencrypt_host::params::plugin,
  String $email                  = $::letsencrypt_host::params::email,
 ) inherits ::letsencrypt_host::params {

 class {'::letsencrypt_host::install':;}
 # lint:endignore
}


