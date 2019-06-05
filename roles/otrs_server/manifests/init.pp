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
    ugentinfo_usage => 'OTRS',
  }

  include ::otrs_instance
}
