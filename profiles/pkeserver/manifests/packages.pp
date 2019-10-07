# Class: pkeserver
# ===========================
#
#
class pkeserver::packages {

  $pkg = ['pxelinux', 'syslinux', 'dnsmasq']
  ensure_packages($pkg)


}
