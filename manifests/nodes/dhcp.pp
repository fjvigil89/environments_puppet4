node 'dhcp.upr.edu.cu' { 
  #este se llama desde roles
  include dhcpprodserver

  #este desde profile
  class {'dhcpserver':
      interfaces   => ['eth0'],
      nameservers  => $basesys::dnsservers,
      pool_enabled => true,
      pool         => [
        'Admin',
        'Servidores-Virtuales',
        'Assets',
        'Trabajadores-BK', 
        'Estudiantes-BK',
        "VM-Noc",
      ],
      network      => [
        '10.2.9.0',
        '10.2.4.0',
        '10.2.132.0', 
        '10.2.133.0',
        '10.2.134.0',
        '10.2.1.0',
      ],
      mask         => [
        '255.255.255.0',
        '255.255.254.0',
        '255.255.255.0',
        '255.255.255.0',
        '255.255.255.0', 
        '255.255.255.0',
      ],
      range        => [
        '10.2.9.200 10.2.9.220',
        '10.2.5.100 10.2.5.120',
        '10.2.132.10 10.2.132.254',
        '10.2.133.2 10.2.133.254',
        '10.2.134.2 10.2.134.254',
        '10.2.1.250 10.2.1.254',
      ],
      gateway      => [
        '10.2.9.1',
        '10.2.5.254',
        '10.2.132.1',
        '10.2.133.1',
        '10.2.134.1', 
        '10.2.1.1',
      ],
    } 
}
