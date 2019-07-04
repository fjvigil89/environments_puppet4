# Class: otrs_server
# ===========================
#
# Full description of class otrs_server here.
#
#
class otrs_server {

  # Add configuration below
  class { '::basesys':
    application     => 'otrs',
    uprinfo_usage => 'OTRS',
  }

  class {'otrs':
    installation_type  => 'web',
    database_connector => 'mysql',
    db_host            => $::fqdn,
    db_name            => 'otrsprod',
    db_user            => 'otrs',
    db_password        => 'plzCr3at3Atick3t',
  }
  #include ::otrs_instance
}
