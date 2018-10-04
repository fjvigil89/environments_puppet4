#Clase virtualhost

class talkserver::virtualhost {
    'upr.edu.cu' :
      ensure   => present,
      ssl_key  => '/etc/ssl/key/mydomain.com.key',
      ssl_cert => '/etc/ssl/crt/mydomain.com.crt',
  }
}
