node 'omv.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class { '::basesys':
    uprinfo_usage   => 'servidor omv',
    application     => 'Open Media Vault',
    proxmox_enabled => false,
    repos_enabled   => false,
    mta_enabled     => false,
  }
}
