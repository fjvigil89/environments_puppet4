class mailserver (
  $application_type,
  String $dir_source = $::mailserver::params::dir_source,
)inherits ::mailserver::params {
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
    config_dir_source    => $mailserver::dir_source,
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

