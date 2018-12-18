# Class: letsencrypt_host:package:
# ===========================
#
# install configuratie.

class letsencrypt_host::package {
  case $::operatingsystem {
      'Debian', 'Ubuntu': {

        $p_os_dependant = [ 'python-certbot-nginx' ]

      }

      'RedHat', 'CentOS': {
        $p_os_dependant = [ 'python2-certbot-nginx' ]
      }
    }
    ensure_packages($p_os_dependant)


}

