# Class: mx_server::spamassassin
# ===========================
#
# Configutarion for spamassassin
#
class mx_server::spamassassin {
  class { 'spamassassin':
  sa_update         => true,
  run_execs_as_user => 'amavis',
  service_enabled   => true,
  bayes_path        => '/var/lib/amavis/bayes'
 } 
}
 
