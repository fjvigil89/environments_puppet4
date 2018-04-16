class roles::dashboard
(
  $puppetdb_host      = 'localhost',
){

  # Add configuration below

  # Configure puppetboard
  class { '::puppetboard':
  puppetdb_host =>  $puppetdb_host,
  puppetdb_port =>  '8080',
  manage_git =>  true,
  manage_virtualenv =>  true,
  enable_catalog =>  true,
  revision =>  '35486e8',
  }

  # Access Puppetboard through 
  include puppetboardserver::apache
}

