class roles::apache2{
  class { 'apache':
    default_vhost =>  false,
  }
}
