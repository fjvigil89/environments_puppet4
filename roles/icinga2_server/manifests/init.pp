#
#  Class icinga2_server
#================================
#

class icinga2_server {
  include ::monitoring::icinga2
  include ::monitoring::icingaweb2
class { '::basesys':
    uprinfo_usage  => 'icinga_server',
    application    => 'icinga',
    puppet_enabled => false;
  }
class { '::php_webserver':
    php_version    => '7.0',
    php_extensions => {
      'curl'     => {},
      'gd'       => {},
      'mysql'    => {},
      'ldap'     => {},
      'xml'      => {},
      'mbstring' => {},
    },
  }

}

