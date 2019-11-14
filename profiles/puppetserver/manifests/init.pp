#
# Class puppetserver
#==================================
#
# Configure puppetserver

class puppetserver  {
  #(String $puppetdb_server = 'localhost')
::apt::source { 'puppetlabs-pc1-server':
    comment  => 'Puppetlabs PC1 Repository',
    location => 'http://repos.upr.edu.cu/puppet/apt',
    repos    => 'PC1',
    key      => {
      id     => '6F6B15509CF8E59E6E469F327F438280EF8D349F',
      server => 'pgp.mit.edu',
    },
  }
  file {'/etc/puppetlabs/puppetserver':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
  class { '::puppet':
    server                      => true,
    server_foreman              => false,
    #server_passenger            => false,
    #server_environments         => [],
    #puppetdb                    => true,
    server_puppetdb_host        => $puppetserver::puppetdb_server,
    #server_reports              => 'puppetdb',
    #server_storeconfigs_backend => 'puppetdb',
    server_jvm_min_heap_size    => '2G',
    server_jvm_max_heap_size    => '2G',
    autosign                    => false,  #'/etc/puppetlabs/code/environments/production/bin/autosign-dns',
    #autosign_mode               => '755',
    server_external_nodes       => '',
    environment                 => 'production',
    version                     => 'latest',
    #version                     => "5.5.1-1${::lsbdistcodename}",
    #server_puppetserver_version => '5.1.0',
    #server_version              => '5.3.5-1puppetlabs1',
    #server_common_modules_path  => '',
    #hiera_config                => '$codedir/hiera.yaml',
    # Staat op agent omdat we de server manueel upgraden!
    manage_packages             => 'server',
    runmode                     => 'cron',
  }
  class { '::r10k':
    r10k_basedir => "/etc/puppetlabs/code/environments",
    cachedir     => "/opt/puppetlabs/r10k/cache",
    configfile   => "/etc/puppetlabs/r10k/r10k.yaml",
    sources      => {
      'environments' => {
        'remote'  => 'git@gitlab.upr.edu.cu:dcenter/environments.git',
        'basedir' => "${r10k_basedir}",
        'prefix'  => false,
        },
      },
    }
  # lint:ignore:140chars
  /*cron {
    'r10k-deploy':
      ensure  => absent,
      command => '[ -x /usr/local/bin/r10k ] && /usr/local/bin/r10k deploy environment -p -c /etc/r10k.yaml',
      minute  => [7,12,17,22,27,32,37,42,47,52,57];
    'serverbeheer2hiera':
      ensure  => present,
      command => '/etc/puppetlabs/code/environments/production/bin/hosts2hiera.pl > /tmp/.hosts_$$ && mv /tmp/.hosts_$$ /var/lib/serverbeheer/data/serverbeheer.yaml',
      minute  => [7,12,17,22,27,32,37,42,47,52,57],
  }*/
  # lint:endignore
  package {
    'libyaml-perl':
      ensure => installed,
  }
  /*# Voor de network puppet module
  package { 'ipaddress':
    ensure   => installed,
    provider => 'puppet_gem',
    require  => Class['::puppet'];
  }
  file {
    '/etc/puppetlabs/code/hiera.yaml':
      ensure => 'file',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/puppetserver/hiera.yaml',
      notify => Exec['restart-puppet-server'];
  }*/
  exec {
    'restart-puppet-server':
      command     => '/etc/init.d/puppetserver restart',
      refreshonly => true;
  }

}
