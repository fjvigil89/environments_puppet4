# Class: reposserver
# ===========================
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2020 Your name here, unless otherwise noted.
#
class reposserver {

  class { '::basesys':
    uprinfo_usage   => 'servidor repositorio paquetes SO',
    application     => 'debmirror',
    proxmox_enabled => false,
    repos_enabled   => false,
    mta_enabled     => false,
    dns_preinstall  => true,
  }

    #Copy SSH SSL
  file { '/root/.ssh/id_rsa':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0400',
    source => 'puppet:///modules/monitoring/ssh_keys/id_rsa',
  }
  file { '/root/.ssh/id_rsa.pub':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0400',
    source => 'puppet:///modules/monitoring/ssh_keys/id_rsa.pub',
  }
  file { '/root/.ssh/config':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/monitoring/ssh_keys/config',
  }


  class {'::r10kserver' :
     r10k_basedir    => "/root/repos",
     #cachedir        => "/var/cache/r10k",
     configfile      => "/root/r10k.yaml",
     remote          => "git@gitlab.upr.edu.cu:dcenter/repos.git",
  }

  file { '/etc/repos':
       ensure  => directory,
       group   => 'bind',
       owner   => 'bind',
       mode    => '0775',
     }~>
    vcsrepo { '/etc/repos':
      ensure   => latest,
      provider => 'git',
      remote   => 'origin',
      source   => {
        'origin' => 'git@gitlab.upr.edu.cu:dcenter/repos.git',
      },
      revision => 'master',
    }




}
