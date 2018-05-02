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
     default_vhost    => false,
     server_signature => 'Off',
     server_tokens    => 'Prod',
     trace_enable     => 'Off',
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
# ->
#  python::pip { 'Flask':
#    virtualenv => '/srv/puppetboard/virtenv-puppetboard',
#  }->
#  python::pip { 'Flask-WTF':
#    virtualenv => '/srv/puppetboard/virtenv-puppetboard',
#  }->
#  python::pip { 'WTForms':
#    virtualenv => '/srv/puppetboard/virtenv-puppetboard',
#  }->
#  python::pip { 'pypuppetdb':
#    virtualenv => '/srv/puppetboard/virtenv-puppetboard',
#  }
#
}
