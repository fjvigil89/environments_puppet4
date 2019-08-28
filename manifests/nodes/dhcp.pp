node 'dhcp.upr.edu.cu' { 
  #este se llama desde roles
  include dhcpprodserver

  #este desde profile
  class {'dhcpserver':
      interfaces   => ['eth0'],
      nameservers  => ['10.2.1.8','10.2.1.13'],
      pool_enabled => true,
      pool         => ['UPR-WIFI' ],
      network      => ['10.2.96.0'],
      mask         => ['255.255.248.0'],
      range        => ['10.2.96.100 10.2.99.254'],
      gateway      => ['10.2.96.1'],
    }
  

}
