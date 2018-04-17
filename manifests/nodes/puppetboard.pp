node 'client-puppet.upr.edu.cu'{
  file {'/tmp/Puppet':
    content =>  'Prueba de puppet server',
  }
  # class {'::puppetboardserve':;}
}
