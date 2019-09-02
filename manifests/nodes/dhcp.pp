node 'dhcp.upr.edu.cu' { 
  #este se llama desde roles
  include dhcpprodserver

  #este desde profile
  class {'dhcpserver':
      interfaces   => ['eth0'],
      nameservers  => ['10.2.1.8','10.2.1.13'],
      pool_enabled => true,
      pool         => ['Servidores-Virtuales','Trabajadores-Docentes','Estudiantes-Docente' ],
      network      => ['10.2.4.0','10.2.70.0', '10.2.64.0'],
      mask         => ['255.255.254.0','255.255.254.0','255.255.255.0'],
      range        => ['10.2.5.100 10.2.5.120','10.2.70.10 10.2.71.254', '10.2.64.5 10.2.64.254'],
      gateway      => ['10.2.5.254','10.2.70.1', '10.2.64.1'],
    }
  

}
