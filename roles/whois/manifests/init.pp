# Class: whois
#
class whois {
  file { '/var/lib/whois':
    ensure => directory,
    group  => 'root',
    owner  => 'root',
    mode   => '0775',
    }~>
    vcsrepo { '/var/lib/whois':
      ensure   => latest,
      provider => 'git',
      remote   => 'origin',
      source   => {
        'origin' => 'git@gitlab.upr.edu.cu:dcenter/whois.git',
      },
      revision => 'master',
    }
}
