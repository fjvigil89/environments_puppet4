# Class: elknodeserver
# ===========================
#
# Full description of class elknodeserver here.
#
# Copyright 2019 Your name here, unless otherwise noted.
#
class elknodeserver{
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage  => 'servidor ELK',
    application    => 'Cluster ELK',
    puppet_enabled => false,
  }

  class {'::elknodeserver::ssh':;}
  ~>class {'::elknodeserver::service':;}
  ~>class {'::elknodeserver::config':;}
}
