#Creacion del nodo
#
node 'mrtg.upr.edu.cu' {
  include mrtgserver
  include git
  include whois
  package { 'lsb-release':
    ensure => installed,
    }~>
    class { '::basesys':
      uprinfo_usage   => 'Servidor mrtg',
      application     => 'mrtg',
      proxmox_enabled => false,
    }
  file { '/var/www/whois':
    ensure => directory,
    group  => 'root',
    owner  => 'root',
    mode   => '0775',
    }~>
    vcsrepo { '/var/www/whois/':
     ensure   => latest,
     provider => 'git',
     remote   => 'origin',
     source   => {
      'origin' => 'git@gitlab.upr.edu.cu:dcenter/whois.git',
        },
     revision => 'master',
     }
}
