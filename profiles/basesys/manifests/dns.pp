# Class: basesys::dns
# ===========================
#
# DNS configuratie.
#
class basesys::dns (
  ){

  if($::basesys::dns_enabled)
  {
    if($::basesys::dmz == true){
      class { '::resolv_conf':
      nameserver => $basesys::dmzservers,
      search     => $basesys::dnssearchdomains,
      }
    }
    else {
       if($::basesys::dns_preinstall)
        {
          class { '::resolv_conf':
                nameserver => $basesys::preinstall_dns,
                search     => $basesys::dnssearchdomains,
          }
        }
      else{
          class { '::resolv_conf':
                nameserver => $basesys::dnsservers,
                search     => $basesys::dnssearchdomains,
          }
      }
  }
  else {
 		class {
      '::resolv_conf':
        nameserver => $facts['ipaddress'],
        search     => $basesys::dnssearchdomains,
    }

  }
}
}
