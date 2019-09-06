# Class: r10kserver
# ===========================
# Copyright 2019 Your name here, unless otherwise noted.
#
class r10kserver {

  class {"r10k":
    r10k_basedir              => "/etc/ansible/environments", 
    r10k_cache_dir            => "/opt/puppetlabs/r10k/cache",
    r10k_config_file          => "/etc/ansible/r10k/r10k.yaml",
    manage_configfile_symlink => true,
    sources => {
      'environments' => {
        'remote'  => 'git@gitlab.upr.edu.cu:frank.vigil/ansible.git',
        'basedir' => "${::settings::confdir}/environments",
        'prefix'  => false,
      },
  },
  }

}
