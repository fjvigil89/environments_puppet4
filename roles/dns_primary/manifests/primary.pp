##class: dns_primary::primary
# ===========================
####
#
class dns_primary::primary(){
  
  bind::server::conf { $::dns_primary::config_file :
    listen_on_addr     => $::dns_primary::listen_on_addr,
    listen_on_v6_addr  => $::dns_primary::listen_on_v6_addr,
    forwarders         => $::dns_primary::forwarders,
    forward            => $::dns_primary::forward,
    allow_query        => $::dns_primary::allow_query,
    directory          => $::dns_primary::directory,
    dump_file          => $::dns_primary::dump_file,
    statistics_file    => $::dns_primary::statistics_file,
    memstatistics_file => $::dns_primary::memstatistics_file,
    zones              => $::dns_primary::zones,
    views              => $::dns_primary::views, 
  }


  if($::dns_primary::slave)
  {
    bind::server::file { $::dns_primary::file_zone_name:
      zonedir     => '/var/lib/bind',
      source_base => 'puppet:///modules/dns_primary/dns/',
      group       => 'bind',
      owner       => 'bind',
      mode        => '0660',
      dirmode     => '0750',
    }

  }
  else {
     file { '/var/lib/bind':
       ensure  => directory,
       group   => 'bind',
       owner   => 'bind',
       mode    => '0775',
     }~>
    vcsrepo { '/var/lib/bind':
      ensure   => latest,
      provider => 'git',
      #remote   => 'origin',
      source   => 'git://gitlab.upr.edu.cu:dcenter/dns_db.git',
      #{
        #'origin' => 'git@gitlab.upr.edu.cu:dcenter/dns_db.git',
        #},
      revision => 'master',
    }
  }

}
