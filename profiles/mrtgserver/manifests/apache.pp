## Manage Apache config 

class mrtgserver::apache(){
  include apache2

  apache::vhost { 'mrtg':
    port       => $port,
    docroot    => $docroot,
    servername => $servername,
    aliases    => $alias,
  }

  apache::vhost { 'whois':
    port       => $port,
    docroot    => '/var/www/whois/ip/web',
    servername => 'whois.upr.edu.cu',
    aliases    => 'whois',
  }
}
