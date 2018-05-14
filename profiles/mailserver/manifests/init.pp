class mailserver {
  class { 'postfix':
  config_file_template => "postfix/${::operatingsystem}/etc/postfix/main.cf.erb",
  config_file_hash     => {
    'portfix'          => {
    config_file_path   => '/etc/postfix',
    config_file_string => "${::fqdn}\n",
    config_file_source => "puppet:///profiles/mailserver/${::operatingsystem}/etc/postfix/main.cf",
  },
    #package_ensure    => 'present',
    #config_dir_purge  => true,
    #config_dir_source => "puppet:///profiles/mailserver/${::operatingsystem}/etc/postfix",

  }


}

