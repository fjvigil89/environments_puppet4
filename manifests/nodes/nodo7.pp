node 'client-puppet.upr.edu.cu'{

  class { '::basesys':
  uprinfo_usage  => 'servidor nodo7',
  application      => 'puppet',
 }
}
