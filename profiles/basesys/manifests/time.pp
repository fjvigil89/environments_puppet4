#class: basesys::time
# ===========================
#
# time configure

class basesys::time {
  if($::basesys::time_enabled) {
    class {
      '::ntp':
        servers         => $basesys::ntp_server,
        #config_template => $basesys::ntpconf,
	config_epp	=> $basesys::ntpconf,
    }
   class { 'timezone':
    	timezone => 'America/Havana',
	}
    # NOTE: NTPd start niet na boot voor RHEL7
    #       https://access.redhat.com/solutions/1315793
    #
    #       Om het eenvoudig te houden verwijderen we
    #       chrony op alle systemen.
    package {
      'chrony':
        ensure => absent;
    }
  }
}
