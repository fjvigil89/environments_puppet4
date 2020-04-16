node 'client-puppet.upr.edu.cu'{
  class { '::basesys':
    uprinfo_usage   	=> 'servidor test',
    application     	=> 'puppet',
    repos_enabled 	=> false,
    #dmz             => true,
    dns_preinstall 	=> true,

  }
$pack = ['python3-pip','build-essential','libssl-dev', 'libffi-dev','python3-dev','python3-venv']
ensure_packages($pack)
}
