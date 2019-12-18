node 'wh-bk.upr.edu.cu'{
  class{'::wh_php_apache':;} 
  apache::vhost { 'sync.upr.edu.cu non-ssl':
    servername    => 'sync.upr.edu.cu',
    serveraliases => ['www.sync.upr.edu.cu'], 
    port          => '80',
    docroot	      => '/home/Sync-UPR/master/public/',
    directories   => [ {
      'path'           => '/home/Sync-UPR/master/public',
      'options'        => ['Indexes','FollowSymLinks','MultiViews'],
      'allow_override' => 'All',
      'directoryindex' => 'index.php',
      },],
      #redirect_status  => 'permanent',
      #redirect_dest    => 'https://sync.upr.edu.cu/',
      }
      #~>
      #apache::vhost { 'sync.upr.edu.cu ssl':
      #  servername    => 'sync.upr.edu.cu',
      #  serveraliases =>  ['www.sync.upr.edu.cu'],
      #  port          => '443',
      #  docroot       => '/home/Sync-UPR/master/public/',
      #  ssl           => true,
      #  #ssl_cert           => "/srv/letsencrypt/live/sync.upr.edu.cu/fullchain.pem",
      #  #ssl_key            => "/srv/letsencrypt/live/sync.upr.edu.cu/privkey.pem",
      #  directories =>  [ {
      #    'path'           => '/home/Sync-UPR/master/public',
      #    'options'        => ['Indexes','FollowSymLinks','MultiViews'],
      #    'allow_override' => 'All',    
      #    'directoryindex' => 'index.php',
      #    },],
      #    }~> 
 apache::vhost { 'contable.upr.edu.cu non-ssl':
   servername       => 'contable.upr.edu.cu',
   serveraliases    => ['www.contable.upr.edu.cu'],
   port             => '80',
   docroot          => '/home/Contable/master/web/',
   directories      => [ {
     'path'           => '/home/Contable/master/web',
     'options'        => ['Indexes','FollowSymLinks','MultiViews'],
     'allow_override' => 'All',
     'directoryindex' => 'app.php',
     },],
     #  redirect_status  => 'permanent',
     #redirect_dest    => 'https://contable.upr.edu.cu/',
     #}~> 
     #apache::vhost { 'contable.upr.edu.cu ssl':
     # servername    => 'contable.upr.edu.cu',
     #serveraliases =>  ['www.contable.upr.edu.cu'],
     #port          => '443',
     #docroot       => '/home/Contable/master/web/',
     #ssl           => true,
     #directories      => [ {
     #'path'    => '/home/Contable/master/web',
     #'options' => ['Indexes','FollowSymLinks','MultiViews'],
     #'allow_override'  => 'All',
     #'directoryindex' => 'app.php',
     #},], 
     }~>
     apache::vhost { 'apiassets.upr.edu.cu':
       servername       => 'apiassets.upr.edu.cu',
       serveraliases    => ['www.apiassets.upr.edu.cu'],
       port             => '80',
       docroot          => '/home/Api-Assets/master/web/',
       directories      => [ {
         'path'           => '/home/Api-Assets/master/web',
         #'options'       => ['Indexes','FollowSymLinks','MultiViews'],
         'allow_override' => 'All',
         'allow'          => 'from All',
         'directoryindex' => 'app.php',
         },],
  #before           => File['/etc/apache2/sites-available/25-apiassets.upr.edu.cu.conf'],
  }
  
  file{'/etc/apache2/sites-available/25-apiassets.upr.edu.cu.conf':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/php_webserver/25-apiassets.upr.edu.cu.conf',
    before => Exec['a2enmod_php7'],
    notify => Exec['service_apache2_restart'];
  }
  
  file{'/etc/freetds/freetds.conf':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/php_webserver/freetds.conf',
  }
  
  exec{"a2enmod_php7":
    command => '/usr/bin/sudo a2enmod php7.0',
  }
  
  exec{"service_apache2_restart":
    command     => '/usr/bin/sudo service apache2 restart',
    refreshonly => true;
  }

  cron{'ActualizarLdap':
    ensure  => present,
    command => 'wget -q -d  --no-check-certificate "http://sync.upr.edu.cu/saber_ldap" > /var/log/sync_upr',
    hour    => [2],
    minute  => 0,
  }

  cron{'ActualizarLosQueSonDeDI':
    ensure  => present,
    command => 'wget -q -d  --no-check-certificate "http://sync.upr.edu.cu/upredes" > /var/log/sync_upr_UPRedes.log',
    hour    => 17,
    minute  => 0,
  }

  cron {'CrearLosNuevosEstudiantesDeIngreso':
    ensure  => present,
    command => 'wget -q -d  --no-check-certificate "http://sync.upr.edu.cu/crear_student" > /var/log/sync_upr_newStudent.log',
    hour    => [23,20],
    minute  => 59,
  }
  cron {'CreacionTrabajadoresNuevos':
    ensure  => present,
    command => 'wget -q -d  --no-check-certificate "http://sync.upr.edu.cu/crear_trabajador_mes" > /var/log/sync_upr_crear_trabajador_mes.log',
    hour    => [2,23],
    minute  => 0,
  }

  class {'::serv_logrotate':
  compress         => true,
  filelog_numbers  => [5,7],
  rotate_frecuency => ['week'],
  rule_list        => ['laravel', 'apache'],
  log_path         => ['/home/Sync-UPR/master/storage/logs/*.log', '/var/log/apache2/*.log'],
}

 file{'/etc/borraram.sh':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/wh_php_apache/borraram.sh',
  }->
 cron{'borrarram':
    ensure  => present,
    command => '/etc/borraram.sh',
    hour    => [1],
    minute  => 0,
  }

}

