node 'dhcp.upr.edu.cu' { 
  #este se llama desde roles
  include dhcpprodserver

  #este desde profile
  class {'dhcpserver':
      interfaces   => ['eth0'],
      nameservers  => ['10.2.1.8','10.2.1.13'],
      pool_enabled => true,
      pool         => ['Servidores-Virtuales','UPR-WIFI','Trabajadores-Docentes' ],
      network      => ['10.2.4.0','10.2.96.0','10.2.70.0'],
      mask         => ['255.255.254.0','255.255.252.0','255.255.254.0'],
      range        => ['10.2.5.100 10.2.5.120','10.2.96.100 10.2.99.254','10.2.70.10 10.2.71.254'],
      gateway      => ['10.2.5.254','10.2.96.1','10.2.70.1'],
    }
  

}
