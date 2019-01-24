# Class: mrtg_server
# ===========================
class mrtgprod_server() {
  package { 'lsb-release':
    ensure => installed,
    }~>
    class { '::basesys':
      uprinfo_usage => 'Servidor mrtg',
      application   => 'mrtg',
      proxmox_enabled => false,
    }
}
