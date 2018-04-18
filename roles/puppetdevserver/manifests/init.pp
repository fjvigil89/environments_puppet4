# Class: puppetdevserver
# ===========================
#
# Full description of class puppetdevserver here.
#
class puppetdevserver{
  
 class { '::basesys':
    uprinfo_usage  => 'Puppet dev server',
    application      => 'puppetserver',
    application_tier => 'dev',
    puppet_enabled   => false;
  }

  class { '::puppetdb_server':;}

  class { '::puppetserver':
    #puppetdb_server => $::fqdn;
    puppetdb_server => 'puppetdb.upr.edu.cu';
  }
}
