#Clase telefonos::apache

class telefonos::apache{
 
 apache::vhost { 'telefonos':
 port       => '80',
 docroot    => '/home/telefonos/web',
 servername => 'telefonos-pup.upr.edu.cu',
 aliases    => 'telefonos',
 }
}
