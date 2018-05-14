class mailserver {
  class { 'postfix':
    config_file_template => "postfix/${::operatingsystem}/etc/postfix/main.cf.erb",
    config_file_hash     => {
    'postfix' => {
      config_file_path   => '/etc/postfix',
      config_file_string => "${::fqdn}\n",
    },
  },
    package_ensure       => 'present',
    config_dir_purge     => true,
  }


}

