# Class: squid_server::common
# ===========================
#
#
class squid_server::common
{
  
 squid::refresh_pattern { '^ftp:':
    min     => 1440,
    max     => 10080,
    percent => 20,
    order   => '60',
  }
  squid::refresh_pattern { '^gopher:':
    min     => 1440,
    max     => 1440,
    percent => 0,
    order   => '61',
  }
  squid::refresh_pattern { '(/cgi-bin/|\?)':
    #case_sensitive => falke,
    min            => 0,
    max            => 0,
    percent        => 0,
    order          => '62',
  }
  squid::refresh_pattern { '.':
    min     => 0,
    max     => 4320,
    percent => 20,
    order   => '63',
  }
  squid::dns_nameservers{'DNS':
    value => join($::basesys::params::dnsservers," "),    #'10.2.1.14 10.2.1.13',
  }

}
