#
#  Class smokeprodserver_server
#================================
#
class smokeprodserver(){
  menu             => ['Router','Cisco','primero','segundo','TP'],
  pagetitle        => ['Conexión de la UPR','Cisco','primero','segundo','TP'],
  hierarchy_parent => ['','Router','Cisco','Cisco','Router'],
  hierarchy_level  => ['1','2','3','3','2'],
  host             => ['10.2.1.1','10.2.1.8','10.2.1.13','10.2.1.140','10.2.1.14'],
}
