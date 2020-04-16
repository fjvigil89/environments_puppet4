node 'client-puppet.upr.edu.cu'{
  class { '::basesys':
    uprinfo_usage   	=> 'servidor test',
    application     	=> 'puppet',
    repos_enabled 	=> true,
    #dmz             => true,

  }
$pack = ['python3-pip','build-essential','libssl-dev', 'libffi-dev','python3-dev']
ensure_packages($pack)
}
