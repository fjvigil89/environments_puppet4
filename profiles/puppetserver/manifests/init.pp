#
# Class puppetserver
#==================================
#
# Configure puppetserver

class puppetserver (String $puppetdb_server = 'localhost') {
::apt::source { 'puppetlabs-pc1-server':
    comment  => 'Puppetlabs PC1 jessie Repository',
    location => 'http://apt.puppetlabs.com',
    repos    => 'PC1',
    key      => {
      id     => '6F6B15509CF8E59E6E469F327F438280EF8D349F',
      server => 'pgp.mit.edu',
    },
  }
  class { '::puppet':
    server                      => true,
    server_foreman              => false,
    server_passenger            => false,
    server_environments         => [],
    server_puppetdb_host        => $puppetserver::puppetdb_server,
    server_reports              => 'puppetdb',
    server_storeconfigs_backend => 'puppetdb',
    server_jvm_min_heap_size    => '3G',
    server_jvm_max_heap_size    => '3G',
    #autosign                    => '/etc/puppetlabs/code/environments/production/bin/autosign-dns',
    #autosign_mode               => '755',
    server_external_nodes       => '',
    environment                 => 'production',
    version                     => "1.10.0-1${::lsbdistcodename}",
    server_puppetserver_version => '2.7.2',
    server_version              => '2.7.2-1puppetlabs1',
    server_common_modules_path  => '',
    hiera_config                => '$codedir/hiera.yaml',
    # Staat op agent omdat we de server manueel upgraden!
    manage_packages             => 'agent',
    # runmode                     => 'cron',
  }
  # lint:ignore:140chars
  cron {
    'r10k-deploy':
      ensure  => absent,
      command => '[ -x /usr/local/bin/r10k ] && /usr/local/bin/r10k deploy environment -p -c /etc/r10k.yaml';
      # minute  => [7,12,17,22,27,32,37,42,47,52,57];
    #'serverbeheer2hiera':
    #  ensure  => present,
    # command => '/etc/puppetlabs/code/environments/production/bin/hosts2hiera.pl > /tmp/.hosts_$$ && mv /tmp/.hosts_$$ /var/lib/serverbeheer/data/serverbeheer.yaml',
    #minute  => [7,12,17,22,27,32,37,42,47,52,57];
  }
  # lint:endignore
  package {
    'libyaml-perl':
      ensure => installed,
  }
  # Voor de network puppet module
  package { 'ipaddress':
    ensure   => installed,
    provider => 'puppet_gem',
    require  => Class['::puppet'];
  }
  file {
    '/var/lib/serverbeheer':
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      before => File['/var/lib/serverbeheer/data'],
  }
  file {
    '/var/lib/serverbeheer/data':
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
  }
  file {
    '/etc/puppetlabs/code/hiera.yaml':
      ensure => 'file',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/puppet4server/hiera.yaml',
      notify => Exec['restart-puppet-server'];
  }

  file {
    '/etc/puppetlabs/eyaml/private_key.pkcs7.pem':
      ensure => 'file',
      owner  => 'puppet',
      group  => 'root',
      mode   => '0440',
  }

  file {
    '/etc/puppetlabs/eyaml':
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      before => File['/etc/puppetlabs/eyaml/private_key.pkcs7.pem'],
  }

  exec {
    'restart-puppet-server':
      command     => '/etc/init.d/puppetserver restart',
      refreshonly => true;
  }

}
