# == Class php_server::params
# This class is meant to be called from basesys
# It set variable according to platform
class php_server::params {
  $verion    = '7.0'
  $pachages  = ['php7.0-mbstring','r10k','php7.0','php7.0-cli','php7.0-curl','php7.0-intl','php7.0-ldap','php7.0-mysql','php7.0-sybase','libapache2-mod-php7.0','php7.0-mcrypt','phpmyadmin','freetds-bin','freetds-common']
}

