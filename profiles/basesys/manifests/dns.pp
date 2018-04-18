# Class: basesys::dns
# ===========================
#
# DNS configuratie.
#
class basesys::dns (
  ){

  if($::basesys::dns_enabled)
  {
    class {
      '::resolv_conf':
        nameserver => $basesys::dnsservers,
        search     => $basesys::dnssearchdomains,
    }
  }
}