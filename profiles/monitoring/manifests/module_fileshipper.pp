#
# Class monitoring::module_fileshipper
#==================================
#
# Configure monitoring::module_fileshipper

class monitoring::module_fileshipper {
#Fileshippet Module
class { 'icingaweb2::module::fileshipper':
  git_revision     => 'master',
  base_directories => {
    basedir => '/var/cache/icinga2',
  },
  directories      => {
    'test' => {
      'source'     => '/usr/local/src/custom-rules.git',
      'target'     => '/zones.d/director-global/custom-rules',
      'extensions' => '.conf, .md',
    }
  }
}
ensure_packages(['php-yaml'],{'ensure' => 'present'})
}


