# == define
#
# Full description of class letsencrypt_host here.
#
#
define letsencrypt_host2 (
# lint:ignore:140chars
  Optional[Array[String]] $dominios        = $::letsencrypt_host::params::dominios,
  Optional[Boolean] $webroot_enable        = false,
  Optional[Array[String]] $webroot_paths   = $::letsencrypt_host::params::webroot_paths,
  Optional[String] $plugin                 = $::letsencrypt_host::params::plugin,
  Optional[String] $email                  = undef,
  Optional[String] $config_dir             = $::letsencrypt_host::params::config_dir,
 )inherits ::letsencrypt_host::params{
   class {'::letsencrypt_host::package':;}
   class {'::letsencrypt_host::install':;}



#   class { 'rsync':
#    package_ensure => 'latest'

#}
#   rsync::get { '/etc/letsencrypt':
#     source  => "rsync://${rsyncServer}/srv/letsencrypt/",
#   }
#lint:endignore
}
