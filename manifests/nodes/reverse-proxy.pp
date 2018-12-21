node 'nginx-inverso.upr.edu.cu','proxy-inverso.upr.edu.cu','toran-proxy.upr.edu.cu' {  
  package { 'lsb-release':
    ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage  => 'servidor proxy inverso',
    application    => 'Reverse Proxy UPR',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
  }
}

##Para hacer los proxy inversos
node /^reverse-proxy\d+$/{

  $hosts = "
  es127.0.0.1     localhost
  ::1             localhost ip6-localhost ip6-loopback
  ff02::1         ip6-allnodes
  ff02::2         ip6-allrouters
  $::ipaddress $::fqdn
  10.2.1.30 puppet-master.upr.edu.cu puppetboard.upr.edu.cu
  10.2.24.85 repos.upr.edu.cu
  10.2.25.12 correo.upr.edu.cu
  10.2.24.142 cvforestal.upr.edu.cu
  10.2.24.48 intranet.upr.edu.cu
  10.2.24.145 proxy-login.upr.edu.cu
  200.14.49.8 nexus.upr.edu.cu harbor.upr.edu.cu
  200.55.143.12 proxy-go.upr.edu.cu
  10.2.1.210 gitlab.upr.edu.cu
  10.2.1.49 icingaweb.upr.edu.cu
  10.2.24.82 composer.upr.edu.cu
  10.2.24.133 bower.upr.edu.cu
  10.2.24.69 cooder.upr.edu.cu
  10.2.24.128 npm.upr.edu.cu
  10.2.24.116 mendive.upr.edu.cu podium.upr.edu.cu cfores.upr.edu.cu cifam.upr.edu.cu coodes.upr.edu.cu revistaecovida.upr.edu.cu 
  10.2.24.120 rc.upr.edu.cu
  10.2.24.119 crai.upr.edu.cu blogcrai.upr.edu.cu
  10.2.24.163 tocororo.upr.edu.cu
  10.2.24.230 eventos.upr.edu.cu
  " 
  file {'dell_hosts':
    ensure => absent,
    path   => '/etc/hosts',
    before => File_line["add_ip_reverse"],
  }
  file_line { 'add_ip_reverse':
    ensure                                => present,
    path                                  => '/etc/hosts',
    line                                  => $hosts,
    replace                               => true,
    #match                                => '^# --- END PVE ---',
    after                                 => '^# --- END PVE ---',
    match_for_absence                     => true,
    replace_all_matches_not_matching_line => true,

  }

  class { 'reverse_proxy_server':
    server_name    => [
      'correo.upr.edu.cu',
      'cvforestal.upr.edu.cu',
      'intranet.upr.edu.cu',
      'proxy-login.upr.edu.cu',
      'nexus.upr.edu.cu',
      'harbor.upr.edu.cu',
      'proxy-go.upr.edu.cu',
      'gitlab.upr.edu.cu',
      'puppetboard.upr.edu.cu',
      'icingaweb.upr.edu.cu',
      'composer.upr.edu.cu',
      'bower.upr.edu.cu',
      'cooder.upr.edu.cu',
      'npm.upr.edu.cu',
      'mendive.upr.edu.cu',
      'podium.upr.edu.cu',
      'cfores.upr.edu.cu',
      'cifam.upr.edu.cu', 
      'coodes.upr.edu.cu',
      'rc.upr.edu.cu',
      'crai.upr.edu.cu',
      'blogcrai.upr.edu.cu',
      'revistaecovida.upr.edu.cu',
      'tocororo.upr.edu.cu',
      'eventos.upr.edu.cu',
    ],
    listen_port    => [80,80,80,443,80,80,443,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80],
    ssl_port       => [443,443,443,443,443,443,443,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80],
    location_allow => [
      '*',
      '*',
      'red_univ',
      '*',
      '*',
      '*',
      '*',
      '*',
      '*',
      '*',
      'red_univ',
      'red_univ',
      'red_univ',
      'red_univ',
      '*',
      '*',
      '*',
      '*',
      '*',
      '*',
      '*',
      '*',
      '*',
      '*',
      '*',
    ],

  }
}
