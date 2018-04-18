node 'client-puppet.upr.edu.cu'{
 class { '::basesys':
  uprinfo_usage =>  'Puppet dev server',
  application =>  'puppetserver',
  application_tier =>  'dev',
  puppet_enabled =>  false;
 }
}
