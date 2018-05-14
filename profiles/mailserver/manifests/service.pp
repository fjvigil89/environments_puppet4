# == Class mailserver::service
# This class is meant to be called from mailserver
# It ensure the service is running
class mailserver::service {
  include mailserver::params
  service { $mailserver::params::service:
    ensure => running,
    enable => true,
  }

	case $mailserver::application_type{
  	'mx':{
      $mailserver::dir_source => 'puppet:///postfix/Ubuntu/mx', 
  	}
  	'email':{
      $mailserver::dir_source => 'puppet:///postfix/Ubuntu/email',
  	}
  }

}
