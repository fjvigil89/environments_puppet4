## Manage Apache config 

class mrtgserver::apache(){
  include apache

  apache::vhost { 'mrtg':
    port       => '80',
    docroot    => '/var/www/mrtg/',
    servername => 'mrtg.upr.edu.cu',
    aliases    => 'mrtg',
  }

  apache::vhost { 'whois':
    port       => '80',
    docroot    => '/var/www/whois/ip/web/',
    servername => 'whois.upr.edu.cu',
    aliases    => 'whois',
  }
}
