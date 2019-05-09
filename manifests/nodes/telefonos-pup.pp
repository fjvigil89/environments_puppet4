node 'telefonos-pup.upr.edu.cu'{

include telefonos

class { '::basesys':
  uprinfo_usage => 'servidor telefonos',
  application   => 'guia de telefonos UPR',
  mta_enabled   => false,
  repos_enabled => false,
  }
  }
