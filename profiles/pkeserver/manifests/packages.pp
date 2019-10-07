# Class: pkeserver
# ===========================
#
#
class pkeserver::packages {

   case $facts['os']['family'] {
      'Centos','RedHat':{
        $pkg = ['']
        }
      'Debian','ubuntu':{
        $pkg = ['pxelinux', 'syslinux', 'dnsmasq']
      }
   }

  ensure_packages($pkg)


}
