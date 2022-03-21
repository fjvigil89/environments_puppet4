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
    source => 'puppet:///modules/reposserver/ssh_keys/id_rsa',
  }
  file { '/root/.ssh/id_rsa.pub':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0400',
    source => 'puppet:///modules/reposserver/ssh_keys/id_rsa.pub',
  }
  file { '/root/.ssh/config':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/reposserver/ssh_keys/config',
  }


  file { '/root/repos':
       ensure  => directory,
       group   => 'root',
       owner   => 'root',
       mode    => '0775',
     }~>
    vcsrepo { '/root/repos':
      ensure   => latest,
      provider => 'git',
      remote   => 'origin',
      source   => {
        'origin' => 'git@gitlab.upr.edu.cu:dcenter/repos.git',
      },
      revision => 'master',
    }


    class {'::r10kserver' :
     r10k_basedir => "/root/repos",
     #cachedir    => "/var/cache/r10k",
     configfile   => "/root/r10k.yaml",
     remote       => "git@gitlab.upr.edu.cu:dcenter/repos.git",
     sources      => {
       'repos' => {
          'remote'           => 'git@gitlab.upr.edu.cu:dcenter/repos.git',
          'basedir'          => '/root/repos',
          'prefix'           => false,
          'invalid_branches' => correct,
       }
     }
  }

  ## Se quito porque no se como porner autoindex en el location
  ## Se hizo a mano esta instalacion
  class {'nginx':   
     manage_repo           => false,
     proxy_connect_timeout => '180s',
     proxy_read_timeout    => '180s',
     proxy_send_timeout    => '180s',
  }

  #nginx::resource::server { $fqdn :
  #www_root => '/var/www/html/repos',
  #}

  file { '/var/www/html/repos':
       ensure => 'link',
       group  => 'root',
       owner  => 'root',
       mode   => '0775',
       target => '/mnt/repos'
     }
  file{"/etc/nginx/sites-enabled/$fqdn.conf":
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/reposserver/vhost.conf',
  }
  file{"/etc/nginx/sites-available/$fqdn.conf":
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/reposserver/vhost.conf',
  }

  exec{"nginx_restart":
    command => '/usr/bin/sudo systemctl restart nginx.service',
  }


}
