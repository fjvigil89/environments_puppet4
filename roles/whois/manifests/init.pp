# Class: whois
#
class whois {
  file { '/var/www/whois':
    ensure => directory,
    group  => 'root',
    owner  => 'root',
    mode   => '0775',
    }~>
     vcsrepo { '/var/www/whois':
       ensure   => latest,
       provider => 'git',
       remote   => 'origin',
       source   => {
         'origin' => 'git@gitlab.upr.edu.cu:dcenter/whois.git',
       },
       revision => 'master',
    }

#Copy SSH Key

  file { '/root/.ssh/id_rsa':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
    source => 'puppet:///modules/whois/keys/id_rsa',
    }

  file { '/root/.ssh/id_rsa.pub':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/whois/keys/id_rsa.pub',
    }

  file { '/root/.ssh/config':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/whois/keys/config',
    }
}
