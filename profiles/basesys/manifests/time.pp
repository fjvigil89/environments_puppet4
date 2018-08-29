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
 else{
   class {
      '::ntp':
        servers => $basesys::ntp_server_upr,
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
    
     # Configure firewall settings
    firewall {
     '010 accept for ntp':       
       dport  => '123',
       proto  => 'udp',
       action => 'accept';

     '011 accept for ntp':       
       dport  => '123',
       proto  => 'tcp',
       action => 'accept';
    } 

 }
}
