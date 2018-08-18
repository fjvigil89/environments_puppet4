# Class: smbr_client
# ===========================
#
# Full description of class smb_rclient here.

class smb_rclient {
  class { '::samba_client':
     shares_name    => 'Informatica',
     shares_comment => 'Repositorio de Informatica',
     shares_path    => '/repositorio/Telecomunicaciones',
     valid_users    => ['tele',],
     writable       => 'yes',
     browseable     => 'yes',
  }
}
