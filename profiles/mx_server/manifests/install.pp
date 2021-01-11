# Class: mx_server::install
# ===========================
#
# Configutarion for install packages don't have 
# available module compatible version with puppet 5
#
class mx_server::install {
 
  package { 'amavisd-new':
    ensure => installed,
  }
  package { 'clamav-daemon':
    ensure => installed,
  }
}

