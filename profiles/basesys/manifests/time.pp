##class: basesys::time
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
    resources {'firewall': purge => true,}
    firewall {     
     '010 accept for ntp':       
       dport  => '123',
       proto  => 'udp',
       action => 'accept';

     '011 accept for ntp':       
       dport  => '123',
       proto  => 'tcp',
       action => 'accept';
     
     '022 accept for ssh':
       dport  => '22',
       proto  => 'tcp',
       action => 'accept';

     '053 accept for dns':
       dport  => '53',
       proto  => 'udp',
       action => 'accept';

     '056 accept for Icinga':
       dport  => '5665',
       proto  => 'tcp',
       action => 'accept';


    } 

 }
}
