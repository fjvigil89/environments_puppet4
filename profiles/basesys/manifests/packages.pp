# Class: basesys::packages
# ===========================
#
# packages configuratie.  packages
#
class basesys::packages {

  if($::basesys::packages_enabled) {
    #class {'::vim':;}
    case $facts['os']['family'] {
      'Centos','RedHat':{
        $ruby_version = 'installed'
        }
      'Debian','ubuntu':{
        $ruby_version = $::lsbdistcodename ? {
        'trusty' => '1.9.1',
        'utopic' => '1.9.1',
        'vivid'  => '1.9.1',
        default  => 'installed',
        }
      }
    }
  include '::firewall'

    class {'::sudo':
      purge               => false,
      config_file_replace => false;
    }

    $rubygems_package = $::operatingsystem ? {
    'Debian' => 'rubygems-integration',
    default  => 'rubygems',
    }
  class { '::ruby':
      version          => $ruby_version,
      rubygems_package => $rubygems_package,
      }
  class { '::ruby::dev':; }
  

    # lint:ignore:80chars
    $p_os_independant = [ 'wget', 'curl', 'man-db', 'bridge-utils', 'at', 'ntpdate', 'subversion-tools',
                          'patchutils', 'ftp', 'rsync', 'binutils', 'make', 'openssl',
                          'xfsprogs', 'bc', 'acl', 'lsof', 'unzip', 'zip', 'screen', 'traceroute',
                          'iproute', 'bzip2', 'dmidecode', 'telnet', 'lvm2', 'tcpdump', 'mdadm',
                          'htop', 'iftop', 'iotop', ]

    case $::operatingsystem {
      'Debian', 'Ubuntu': {

        $p_os_dependant = [ 'gem','perl-doc', 'bind9-host',
                            'ldap-utils', 'libwrap0-dev', 'arping', 
                            'libconfig-general-perl', 'netcat',
                            'links2', 'dnsutils','python-apt', 'ifupdown-extra','monitoring-plugins','libwww-perl','tzdata','mlocate','libmonitoring-plugin-perl' ]

        $packagelist_dist = $::lsbdistcodename ? {
          'lenny'   => [ 'scsiadd', 'cpp-doc','gcc-doc', 'automake1.4'],
          'lucid'   => [ 'scsiadd', 'cpp-doc','gcc-doc', 'timeout', 'automake1.4'],
          'precise' => [ 'cpp-doc','gcc-doc', 'automake1.4' ],
          'trusty'  => [ 'cpp-doc','gcc-doc', 'automake1.4' ],
          'utopic'  => [ 'cpp-doc','gcc-doc', 'automake1.4' ],
          'vivid'   => [ 'cpp-doc','gcc-doc', 'automake1.4' ],
          'xenial'  => [ 'cpp-doc','gcc-doc'],
          'jessie'  => [ 'gcc-doc-base', 'automake1.11', 'jq'],
          default   => [ 'gcc-doc-base'],
        }
        ensure_packages($packagelist_dist)

        $dhcp_client_package = $::lsbdistcodename ? {
          'lenny'         => 'isc-dhcp-client',
          'squeeze'       => 'dhcp3-client',
          'lucid'         => 'dhcp3-client',
          default         => 'isc-dhcp-client',
        }
        ensure_packages($dhcp_client_package)
      }

      'RedHat', 'CentOS': {
        $p_os_dependant = [ 'dhcp', 'nc', 'libconfig', 'tzdata','nagios-plugins-all' ]
      }
    }

    ensure_packages($p_os_dependant)
    ensure_packages($p_os_independant)

    #$legacy_ugent_nagios_package = $::osfamily ? {
    #  'Debian' => 'ugent-nagios-client',
    #  'RedHat' => 'ugnagiosclient',
    #  default  => 'ugent-nagios-client'
    #}

    # 'ugent-nagios-client' heeft voorlopig een Bug #SYSADMIN-89
    #ensure_packages($legacy_ugent_nagios_package, {'ensure' => 'absent'})

    # lint:endignore
  }

}
