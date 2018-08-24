# Class: smbr_client
# ===========================
#
# Full description of class smb_rclient here.

class smb_rclient {
    class { '::basesys':
    uprinfo_usage  => 'servidor NOC',
    application    => 'Noc Server UPR',
    puppet_enabled => false,
    repos_enabled  => true,
    mta_enabled    => false,
  }
  class { '::samba_client':
     shares_name    => 'Informatica',
     shares_comment => 'Repositorio de Informatica',
     shares_path    => '/repositorio/Telecomunicaciones',
     valid_users    => ['tele',],
     writable       => 'yes',
     browseable     => 'yes',
  }
}
