# Class: elkserver
# ===========================
#
# Full description of class elkserver here.
class elkserver {

  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage  => 'servidor ELK',
    application    => 'ELK',
    repos_enabled  => false,
    puppet_enabled => false
    
  }

  $packages=['apt-transport-https', 'software-properties-common', 'wget','pwgen','ufw']
  ensure_packages($packages, {
    ensure => present,
    })

  include git

  class {'::elasticsearchserver':;}~>
  class {'::kibanaserver':;}~>
  class {'::logstashserver':;}~>
  class {'::elkserver::config':;}

}
