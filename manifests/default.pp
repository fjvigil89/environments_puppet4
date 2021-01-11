node default {
    
  notify{'default_node_inclusion':
    message =>  'Este nodo no tiene manifest.',
  }
class { '::basesys':
    uprinfo_usage   => 'Default',
    application     => 'CT y MV',
    proxmox_enabled => false,
    repos_enabled   => false,
    mta_enabled     => false,
    dmz             => false,
    puppet_enabled  => true,
    dns_preinstall  => true,
  }
}
