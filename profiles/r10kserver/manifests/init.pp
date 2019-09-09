# Class: r10kserver
# ===========================
# Copyright 2019 Your name here, unless otherwise noted.
#
class r10kserver(
  $r10k_basedir              = "/etc/ansible/environments",
  $cachedir                  = "/var/cache/r10k",
  $configfile                = "/etc/ansible/r10k/r10k.yaml",
  $manage_configfile_symlink = true,
) {

  class {"r10k":
    r10k_basedir              => "/etc/ansible/environments", 
    cachedir                  => "/var/cache/r10k",
    configfile                => "/etc/ansible/r10k/r10k.yaml",
    manage_configfile_symlink => true,
    sources                   => {
      'environments' => {
        'remote'  => 'git@gitlab.upr.edu.cu:frank.vigil/ansible.git',
        'basedir' => "${r10k_basedir}",
        'prefix'  => false,
      },
  },
  }

}
