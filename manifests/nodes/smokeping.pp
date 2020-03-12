#Creacion del nodo
node 'smokeping.upr.edu.cu'{
  include smokeprodserver
  class {'smokeserver':
    target           => ['Routers','L3','PAP','FCP','FCF','Docente','CUM','Vinales','Palacios','San_Luis','Minas','Guane','Mantua','La_Palma','Sandino','Consolacion','UD','Camilo','Macurije','Guanahacabibes','Soroa'],
    menu             => ['Routers','Switch L3 Nodo Central','Router PAP','Router FCP','Router FCF','Router Docente','CUM','Viñales','Los Palacios','San Luis','Minas','Guane','Mantua','La Palma','Sandino','Consolacion','UD','Camilo Cienfuegos','Macurije','Guanahacabibes','Soroa'],
    hierarchy_level  => [1,2,2,2,2,2,1,2,2,2,2,2,2,2,2,2,1,2,2,2,2],
    hierarchy_parent => ['Routers','Routers','Routers','Routers','Routers','Routers','CUM','CUM','CUM','CUM','CUM','CUM','CUM','CUM','CUM','CUM','UD','UD','UD','UD','UD'],
    host             => ['','10.2.1.1','10.2.1.5','10.2.0.10','10.2.8.200','10.2.0.128','','10.2.20.49','10.2.20.119','10.2.20.177','10.2.20.33','10.2.20.209','10.2.20.17','10.2.20.165','10.2.20.1','10.2.20.145','','10.2.21.1','10.2.20.97','10.2.20.113','10.2.20.161'],
  }
}
