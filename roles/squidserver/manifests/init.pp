# Class: squidserver
# ===========================
#
class squidserver(

)inherits ::squidserver::params {
  
  class { 'squid_server':
    http_ports                     => { 'http' => { port => '8080', }},
    https_ports                    => { 'https' => { port => '8443',}},
    icp_access                     => { 'icp_access'=>{ action => 'deny', value =>'all',}},
    icp_port                       => { 'icp_port'=>{ port =>'0', }},
    cache_mem                     => '2048 MB',
    maximum_object_size_in_memory => '1024 KB',
    memory_replacement_policy     => 'heap GDSF',
    cache_replacement_policy      => 'heap LFUDA',
     cache                        => {'cache'=> { action => 'allow', value =>'all', }},
    forwarded_for                  => false,
    via                            => false,

  }

  squidserver::acl { 'CONNECT':
    type    => method,
    entries => ['CONNECT'],
  }

  squidserver::acl{ 'SSL_ports' :
    type    => port,
    entries => ['443']
  }
  squidserver::acl { 'Safe_ports':
    type    => port,
    entries => ['80','443','21','70','210','1025-65535','280','488','591','777','901'],
  }
  squidserver::acl { 'red_pap':
    type    => src,
    entries => ['10.71.46.0/24 20.0.0.0/24 10.2.9.0/24 10.2.75.0/25'],

  }
  squidserver::acl { 'ldapauth':
    type    => proxy_auth,
    order   => '4',
    entries => ['REQUIRED'],
  }
  squidserver::acl { 'AccesoAlGrupo':
    type    => external,
    order   => '4',
    entries => ['ADGroup UPR-Internet-Profes UPR-Internet-NoDocente UPR-Internet-Est'],
  }


  squidserver::tcp_outgoing_address{'OutGoing':
    value    => ['200.14.49.29'],
    acl_name => ['red_pap']
  }

  squidserver::cache_peer{'cache_peer':
    pattern    => ["${::ip}"],
    type       => ['sibling'],
    proxy_port => ['8080'],
    icp_port   => ['0'],
    #options    => ['no-query'],
  }

  squid::auth_param { 'basic auth_param':
    order   => '400',
    scheme  => 'basic',
    entries => [
      'program /usr/lib/squid3/basic_ldap_auth -R -v 3 -b "dc=upr,dc=edu,dc=cu" -D internet@upr.edu.cu -w P@ssword -f (|(userPrincipalName=%s)(sAMAccountName=%s)) -h 10.2.24.35',
      'children 10',
      'realm Servidor Proxy de la UPR',
      'credentialsttl 2 hours',
    ],
  }
  squid::extra_config_section { 'external_acl_type':
    order          => '400',
    config_entries => [{
      'external_acl_type' => [
        'ADGroup    %LOGIN /usr/lib/squid3/ext_ldap_group_acl -R -v 3 -b "dc=upr,dc=edu,dc=cu" -D internet@upr.edu.cu -w P@ssword -f "(&(objectclass=person)(sAMAccountName=%v)(memberof=cn=%a,ou=_Gestion,dc=upr,dc=edu,dc=cu))" -h 10.2.24.35',
      ],
    }],
  }







}
