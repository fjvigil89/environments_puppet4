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
    timezone => 'America/Havana',
      #package_ensure => 'present',
      #manage_package => true,
    }

    package {
        'chrony':
        ensure => absent;
    }
  }
}
