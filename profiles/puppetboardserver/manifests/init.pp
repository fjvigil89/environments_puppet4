# Class: puppetboardserver
# ===========================
#
# Full description of class puppetboardserver here.
#
#
class puppetboardserver(
  String $puppetdb_host      = 'localhost',
) {

  # Add configuration below

  # Configure puppetboard
  class { '::puppetboard':
    puppetdb_host     => $puppetdb_host,
    puppetdb_port     => '8001',
    manage_git        => true,
    manage_virtualenv => true,
    enable_catalog    => true,
    revision          => '35486e8',
  }

  # Access Puppetboard through pboard.example.com
  class { 'puppetboard::apache::vhost':
    vhost_name  => 'pboard.upr.edu.cu',
    port        => '80',
  }

  # Access Puppetboard through 
  class { '::puppetboardserver::apache':;}
}
