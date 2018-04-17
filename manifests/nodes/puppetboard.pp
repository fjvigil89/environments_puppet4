node 'client-puppet.upr.edu.cu'{
  file{'/tmp/otro':
  content => 'Otra prueba2',
  }

  class {'puppetboardserver':}
}
