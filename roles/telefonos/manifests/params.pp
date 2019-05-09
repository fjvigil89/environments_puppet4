# == Class telefonos::params
# This class is meant to be called from basesys
# It set variable according to platform

  class telefonos::params {
    $version    = '7.2'
    $pachages  = ['php7.2-mbstring','r10k','php7.2','php7.2-cli','php7.2-curl','php7.2-intl','php7.2-ldap','php7.2-mysql','php7.2-sybase','libapache2-mod-ph    p7.2','php7.2-mcrypt','freetds-bin','freetds-common']
    }
