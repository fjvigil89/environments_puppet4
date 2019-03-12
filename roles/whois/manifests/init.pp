# Class: whois
#
class whois {
  file { '/var/www/whois':
    ensure => directory,
    group  => 'root',
    owner  => 'root',
    mode   => '0775',
    #  }~>
    #vcsrepo { '/var/www/whois':
    #  ensure   => latest,
    #  provider => 'git',
    #  remote   => 'origin',
    #  source   => {
    #    'origin' => 'git@gitlab.upr.edu.cu:dcenter/whois.git',
    #  },
    #  revision => 'master',
    }
}
