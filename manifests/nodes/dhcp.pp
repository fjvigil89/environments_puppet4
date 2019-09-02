node 'dhcp.upr.edu.cu' { 
  #este se llama desde roles
  include dhcpprodserver

  #este desde profile
  class {'dhcpserver':
      interfaces   => ['eth0'],
      nameservers  => ['10.2.1.8','10.2.1.13'],
      pool_enabled => true,
      pool         => ['Servidores-Virtuales','Trabajadores-Docentes','Estudiantes-Docente','Profesores-Rectoria', 'Rectoria-SecG.','CRAI', 
                      'Estudiantes-Rectoria'],
      network      => ['10.2.4.0','10.2.70.0', '10.2.64.0', '10.2.80.0', '10.2.81.128','10.2.83.0', '10.2.82.0'],
      mask         => ['255.255.254.0','255.255.254.0','255.255.255.0','255.255.255.0','255.255.255.128','255.255.255.0', '255.255.255.0'],
      range        => ['10.2.5.100 10.2.5.120','10.2.70.10 10.2.71.254', '10.2.64.5 10.2.64.254','10.2.80.5 10.2.80.254', '10.2.81.130 10.2.81.254',
                      '10.2.83.101 10.2.83.254', '10.2.82.5 10.2.82.254'],
      gateway      => ['10.2.5.254','10.2.70.1', '10.2.64.1', '10.2.80.1', '10.2.81.129', '10.2.83.1', '10.2.82.1'],
    }
  

}
