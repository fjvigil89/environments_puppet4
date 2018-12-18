# == Class: letsencrypt_host
#
# Full description of class letsencrypt_host here.
#
#
class letsencrypt_host (
# lint:ignore:140chars
  Optional[Array[String]] $dominios        = $::letsencrypt_host::params::dominios,
  Optional[Boolean] $webroot_enable        = false,
  Optional[Array[String]] $webroot_paths   = $::letsencrypt_host::params::webroot_paths,
  Optional[String] $plugin                 = $::letsencrypt_host::params::plugin,
  Optional[String] $email                  = undef,
 )inherits ::letsencrypt_host::params{
   class {'::letsencrypt_host::package':;}
   class {'::letsencrypt_host::install':;}

   
#lint:endignore
}


