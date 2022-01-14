#Creacion del nodo
node 'smokeping.upr.edu.cu'{
  include smokeprodserver
  class {'smokeserver':
    target           => ['Routers','L3','PAP','FCP','FCF','Docente','CUM','Sandino','Mantua','Minas','Vinales','La_Palma','Palacios','Consolacion','San_Luis','Guane','UD','Camilo','Macurije','Guanahacabibes','Soroa'],
    menu             => ['Routers','Switch L3 Nodo Central','Router PAP','Router FCP','Router FCF','Router Docente','CUM','Sandino .1','Mantua .17','Minas .33','Viñales .49','La Palma .65','Los Palacios .129','Consolacion .145','San Luis .177','Guane .209','Unidades Docentes','Camilo Cienfuegos .81','Macurije .97','Guanahacabibes .113','Soroa .161'],
    hierarchy_level  => [1,2,2,2,2,2,1,2,2,2,2,2,2,2,2,2,1,2,2,2,2],
    hierarchy_parent => ['Routers','Routers','Routers','Routers','Routers','Routers','CUM','CUM','CUM','CUM','CUM','CUM','CUM','CUM','CUM','CUM','UD','UD','UD','UD','UD'],
    host             => ['','10.2.1.1','10.2.1.2','10.2.0.161','10.2.0.200','10.2.0.128','','10.2.20.1','10.2.20.17','10.2.20.33','10.2.20.49','10.2.20.65','10.2.20.129','10.2.20.145','10.2.20.177','10.2.20.209','','10.2.20.81','10.2.20.97','10.2.20.113','10.2.20.161'],
  }
}
