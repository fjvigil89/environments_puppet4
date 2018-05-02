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
	class {'apache':
		purge_configs => false,
  	mpm_module    => 'prefork',
  	default_vhost => true,
  	default_mods  => false,
   }

  # Configure puppetboard
#  class { '::puppetboard':
#    puppetdb_host     => $puppetdb_host,
#    puppetdb_port     => '8080',
#    manage_git        => true,
#    manage_virtualenv => true,
#    enable_catalog    => true,
#    revision          => '35486e8',
#  }

 	class { 'apache::mod::wsgi':
     wsgi_socket_prefix => '/var/run/wsgi',
   }

   #Configure Puppetboard
   class { 'puppetboard':
     puppetdb_host       => $puppetdb_host,
     puppetdb_port       => 8080,
     default_environment => '*',
     manage_git          => true,
     manage_virtualenv   => true,
     reports_count       => 50
   }
   class { 'puppetboard::apache::conf': }
}
