node 'client-puppet.upr.edu.cu'{

  class { '::basesys':
  uprinfo_usage  => 'servidor test',
  application      => 'puppet',
  puppet_enabled   => false;
  }

  #class {'mailserver':;}


class { '::php::globals':
  php_version => '7.0',
  config_root => '/etc/php/7.0',
}->
class { '::php':
  manage_repos => true
}


}
