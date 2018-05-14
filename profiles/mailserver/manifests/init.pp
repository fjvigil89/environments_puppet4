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
    #config_dir_source   => 'puppet:///postfix/Ubuntu/etc/postfix',
    config_dir_source    => "puppet:///modules/postfix/${::operatingsystem}/etc/postfix",
    #case $mailserver::application_type{
    #  'mx':{
    #  config_dir_source => 'puppet:///postfix/Ubuntu/mx',
    #}
    #  'email':{
    #  config_dir_source => 'puppet:///postfix/Ubuntu/email',
    #}
  }
  #class {'::mailserver::service':;}
  

}

