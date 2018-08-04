# Class: mx_server::spamassassin
# ===========================
#
# Configutarion for spamassassin
#
class mx_server::spamassassin {
  }
  #  ensure_packages('zoo','unzip','bzip2','libnet-ph-perl','libnet-snpp-perl','libnet-telnet-perl','nomarch','lzop')
  class { 'spamassassin':
  sa_update         => true,
  run_execs_as_user => 'amavis',
  service_enabled   => true,
  bayes_path        => '/var/lib/amavis/bayes'
 } 
}
 
