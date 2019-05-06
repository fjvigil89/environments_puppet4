node 'telefonos-pup.upr.edu.cu' {  

include telefonos

package { 'lsb-release':
	ensure => installed,
      }~>
    class { '::basesys':
      uprinfo_usage  => 'Telefonos de la UPR',
      application    => 'Guía Telefónica UPR',
      puppet_enabled => false,
      repos_enabled  => true,
      mta_enabled    => false,
      }
     }
