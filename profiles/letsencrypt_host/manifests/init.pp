# == Class: letsencrypt_host
#
# Full description of class letsencrypt_host here.
#
#
class letsencrypt_host (
# lint:ignore:140chars
  Array[String] $dominios        = $::letsencrypt_host::params::dominios,
  Boolean $webroot_enable        = false,
  Array[String] $webroot_paths   = $::letsencrypt_host::params::webroot_paths,
  String $plugin                 = $::letsencrypt_host::params::plugin,
  String $email                  = $::letsencrypt_host::params::email,
 )inherits ::letsencrypt_host::params{
   class {'::letsencrypt_host::install':;}
   #lint:endignore
}


