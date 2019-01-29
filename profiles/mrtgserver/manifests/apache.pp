## Manage Apache config 

class mrtgserver::apache(){
  
  include apache2

  apache::vhost { 'mrtg':
    port          => $port,
    docroot       => $docroot,
    servername    => $servername,
    aliases       => $alias,
  }
}
