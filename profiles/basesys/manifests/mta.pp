# Class: basesys::mta
# ===========================
#
# Configutarion for MTA
#
class basesys::mta (
  ){

  if($::basesys::mta_enabled) {
    class { '::postfix':
        root_alias => $basesys::root_alias,
        postmaster => $basesys::postmaster,
    }
  }
  }
