# Class: basesys::dns
# ===========================
#
# DNS configuratie.
#
class basesys::proxy (
  ){

  if($::basesys::proxy_enabled)
  {

  file{'/etc/apt/apt.conf.d/80proxy':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/basesys/80proxy',
  }


  }
}

