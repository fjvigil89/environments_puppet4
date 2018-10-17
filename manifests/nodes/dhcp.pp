node 'dhcp.upr.edu.cu' { 
  #este se llama desde roles
  include dhcpprodserver

  #este desde profile
  class {'dhcpserver':
      interfaces   => ['eth0'],
      nameservers  => ['10.2.1.14','10.2.1.13'],
      pool_enabled => true,
      pool         => ['Gestion','ICT','CECES','NODO','Servidores-Fisicos','Serv-Virtuales','Edificio Rectoria','Wifi-FCF-Docente','Wifi-Rectoria','Lab-EstGeologia',
      'Lab-EstMecanica','Lab-Mecalografia','Rectorado-SecGral','LabInfo-VLIR'],
      network      => ['10.2.1.0','10.2.14.0','10.2.5.0','10.2.9.0','10.2.22.0','10.2.24.0','10.2.72.0','10.2.29.0','10.2.30.128','10.2.73.128','10.2.74.0',
      '10.2.74.128','10.2.75.0','10.2.63.0'],
      mask         => ['255.255.255.0','255.255.255.0','255.255.255.128','255.255.255.128','255.255.255.0','255.255.252.0','255.255.252.0','255.255.255.128',
      '255.255.255.128','255.255.255.128','255.255.255.128','255.255.255.128','255.255.255.128','255.255.255.0'],
      range        => ['10.2.1.220 10.2.1.253','10.2.14.10 10.2.14.254','10.2.5.10 10.2.5.100','10.2.9.60 10.2.9.100','10.2.22.200 10.2.22.240',
      '10.2.24.0 10.2.27.240','10.2.72.2 10.2.72.250','10.2.29.11 10.2.29.60','10.2.30.139 10.2.30.250','10.2.73.130 10.2.73.250','10.2.74.2 10.2.74.126',
      '10.2.74.130 10.2.74.254','10.2.75.2 10.2.75.120','10.2.63.11 10.2.63.250'],
      gateway      => ['10.2.1.1','10.2.14.1','10.2.5.1','10.2.9.1','10.2.22.1','10.2.24.1','10.2.72.1','10.2.29.1','10.2.30.129','10.2.73.129','10.2.74.1',
      '10.2.74.129','10.2.75.1','10.2.63.1'],
    }
  

}
