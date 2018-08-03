# Class: basesys::spamassassin
# ===========================
#
# Configutarion for spamassassin
#
class basesys::spamassassin {
  include razor::server
  package { 'amavisd-new':
    ensure => installed,
  }
  package { 'clamav-daemon':
    ensure => installed,
  }
  package { 'pyzor':
    ensure => installed,
  }
  #  ensure_packages('zoo','unzip','bzip2','libnet-ph-perl','libnet-snpp-perl','libnet-telnet-perl','nomarch','lzop')
  class { 'spamassassin':
  sa_update         => true,
  run_execs_as_user => 'amavis',
  service_enabled   => false,
  bayes_path        => '/var/lib/amavis/bayes'
  #razor_home        => '/var/lib/amavis/.razor',
  #pyzor_home        => '/var/lib/amavis/.pyzor',
 } 
}
 
