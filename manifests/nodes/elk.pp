node 'elk.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'servidor ELK',
    application     => 'ELK',    
    #repos_enabled   => true,
    #mta_enabled     => false,
  }


  $packages=['apt-transport-https', 'software-properties-common', 'wget']
  ensure_packages($packages, {
    ensure => present,
    })

  include git
  vcsrepo { '/tmp':
      ensure     => latest,
      provider   => 'git',
      remote     => 'origin',
      source     => {
        'origin' => 'git@gitlab.upr.edu.cu:dcenter/elasticsearch.git',
      },
      revision   => 'master',
  }->
  exec{"mv_jdk8":
    command => '/usr/bin/sudo mv elasticsearch/jdk-8u131-linux-x64.tar.gz /tmp',
  }->
  class {'::elasticsearchserver':;}->
  class {'::kibanaserver':;}
}
