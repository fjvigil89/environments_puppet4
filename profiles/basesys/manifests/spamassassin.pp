# Class: basesys::spamassassin
# ===========================
#
# Configutarion for spamassassin
#
class basesys::spamassassin {
  include razor::server
  class { 'spamassassin':
  sa_update         => true,
  run_execs_as_user => 'amavis',
  service_enabled   => false,
  bayes_path        => '/var/lib/amavis/bayes'
  #razor_home        => '/var/lib/amavis/.razor',
  #pyzor_home        => '/var/lib/amavis/.pyzor',
 } 
}
  
