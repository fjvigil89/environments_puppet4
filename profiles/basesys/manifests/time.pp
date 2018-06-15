#class: basesys::time
# ===========================
#
# time configure

class basesys::time {
  if($::basesys::time_enabled) {
    class {
      '::ntp':
        servers => $basesys::ntp_server,
        #config_template => $basesys::ntpconf,
  config_epp    => $basesys::ntpconf,
    }
  class {'::timezone':
    region   => 'America',
    locality => 'Havana',
    }

    package {
        'chrony':
        ensure => absent;
    }
  }
}
