#Clase virtualhost

class talkserver::virtualhost {
  'upr.edu.cu' :
    ensure   => present,
    #ssl_key  => '/etc/ssl/key/sync.upr.edu.cu.key',
    #ssl_cert => '/etc/ssl/crt/sync.upr.edu.cu.crt',
    }

