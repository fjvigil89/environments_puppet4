node 'dhcp-bk.upr.edu.cu' { 
  #este se llama desde roles
  include dhcpprodserver

  #este desde profile
  class {'dhcpserver':
      interfaces   => ['eth0'],
      pool_enabled => true,
      pool         => ['Gestion','Assets','Trabajadores','Estudiantes','wifi-bk'],
      network      => ['10.2.128.0','10.2.132.0','10.2.133.0','10.2.134.0','10.2.30.64'],
      mask         => ['255.255.255.0','255.255.255.0','255.255.255.0','255.255.255.0','255.255.255.192'],
      range        => ['10.2.128.150 10.2.128.253','10.2.132.10 10.2.132.254','10.2.133.2 10.2.133.254','10.2.134.2 10.2.134.254','10.2.30.75 10.2.30.126'],
      gateway      => [10.2.128.1,'10.2.132.1','10.2.133.1','10.2.134.1','10.2.30.65'],
      host_enabled => false,
      host         => ['assets.upr.edu.cu'],
      comment      => ['Servidor Assets para Contabilidad'],
      mac          => ['72:92:c5:24:74:e4'],
      ip           => ['10.2.132.101']
    }
  

}
