node 'client-puppet.upr.edu.cu'{

  class { '::basesys':
  uprinfo_usage  => 'servidor test',
  application      => 'puppet',
  puppet_enabled   => false;
  }

  class {'mailserver':
  application_type =>'mx';    
  }

}
