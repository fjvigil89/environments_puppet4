# == Class php_server::params
# This class is meant to be called from basesys
# It set variable according to platform
class php_server::params {
  $verion    = '7.2'
  $pachages  = ['php7.2-mbstring','r10k','php7.2','php7.2-cli','php7.2-curl','php7.2-intl','php7.2-ldap','php7.2-mysql','php7.2-sybase','libapache2-mod-php7.2','php7.2-mcrypt','phpmyadmin','freetds-bin','freetds-common']
}

