# Class: basesys::repos
# ===========================
#
# Configuration of repos
#
class basesys::repos (
){

  if($basesys::repos_enabled){

    # Debian/Ubuntu needs the module
    # Rhel based OS can use yum resource
    if($::osfamily == 'Debian') { 
      file { "/etc/apt/apt.conf.d/80update":
        ensure => file,
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
        source => 'puppet:///modules/basesys/aptconf/80update',
      }~>
      class {
        '::apt':
          purge  => {
            'sources.list'   => true,
            'sources.list.d' => true,
          },
          update => {
            'tries'     => 3,
            'frequency' => 'always',
          },
      }
      # Add exception for apt-transport-https to avoid dependency loops
      Class['apt::update'] -> Package <| title != 'apt-transport-https' |>
      # apt-https-transport Add
      #(In debian 10/ubuntu 18.04 is this no longer necessary, but as a dummy package available)
      # Managed by the Apt module from version 4.4.0
        ensure_packages(['apt-transport-https'], {
          ensure => present,
          })
    }
    }

    # Debs repository with packages created / hosted at UPR    
     case $::osname {
       'Ubuntu': {
         #Ubuntu 18.04 have a problem to add key
         ensure_packages(['gnupg'], {
           ensure => present,
           })
        apt::source { 'debs':
            comment  => 'UPR debs repo',
            location => "http://${basesys::repo_url}/ubuntu/",
            repos    => 'main',
        }
        apt::source {
          'icinga':
            comment  => 'Upr icinga',
            location => 'http://repos.upr.edu.cu/icinga/ubuntu/',
            repos    => "icinga-${::lsbdistcodename} main",
        }
      }
      'CentOS': {
        yumrepo { 'debs-upr':
            descr    => 'UPR RHEL repo',
            name     => 'debs-upr',
            gpgcheck => '0',
            enabled  => '1',
            baseurl  => "http://repos.upr.edu.cu/CentOS/${::operatingsystemmajrelease}";

          'icinga2':
            descr    => 'UPR Icinga',
            name     => 'icinga-upr',
            gpgcheck => '1',
            enabled  => '1',
            gpgkey   => "http://repos.upr.edu.cu/icinga/icinga.key",
            baseurl  => "http://repos.upr.edu.cu/icinga/epel/${::osreleasemajor}/release";
          
        }
      }

      'Debian': {
        apt::source { 'debs':
            comment  => 'UPR debs repos Debian',
            location => "http://${basesys::repo_url}debian/",
            repos    => 'main',
        }
      }
      default: {}
    }
    
    #OS repos, at Debian based we take into account aptly_mirror variable
    case $::operatingsystem{
      'Debian': {
        if($basesys::aptly_mirror != ''){
          apt::source {
            'aptly-mirror':
              comment  => "Aptly mirror ${basesys::aptly_mirror}",
              location => "http://${basesys::repo_url}/debian/${basesys::aptly_mirror}",
              repos    => 'main',
          }
        } else {
          apt::source { "debian-upr-${lsbdistcodename}":
              comment  => 'Debian UPR repo',
              location => "http://${basesys::repo_url}/debian/",
              repos    => 'main non-free contrib',
          }
         
          apt::source { "debian-upr-${lsbdistcodename}-updates":
              comment  => 'Debian UPR repo',
              location => "http://${basesys::repo_url}/debian/",
              repos    => 'main non-free contrib',
              release  => "${lsbdistcodename}-updates"
          }
           
          apt::source { "debian-upr-${lsbdistcodename}-backports":
              comment  => 'Debian UPR repo',
              location => "http://${basesys::repo_url}/debian/",
              repos    => 'main non-free contrib',
              release  => "${lsbdistcodename}-backports"
          }
					
					apt::source { "debian-security":
              comment  => 'Debian Security repo',
              location => "http://${basesys::repo_url}/debian-security/",
              repos    => 'main non-free contrib',
              release  => "${::lsbdistcodename}/updates",
          }
          apt::source { 'icinga':
              comment  => 'Icinga UPR',
              #location => 'http://repos.upr.edu.cu/icinga/debian/',
              location => 'http://packages.icinga.com/debian/',
              repos    => 'main',
              release  => "icinga-${::lsbdistcodename}",
              key      => {
                'id'     => 'F51A91A5EE001AA5D77D53C4C6E319C334410682',
                #'source' => 'http://repos.upr.edu.cu/icinga/icinga.key',
                'source' => 'http://packages.icinga.com/icinga.key',
              }
              }
          if($::is_virtual == false){
						apt::source { "proxmox":
              comment  => 'Proxmox repo',
              #location => 'http://repos.upr.edu.cu/proxmox/pve/',
              location => 'http://download.proxmox.com/debian/pve',
              repos    => 'pve-no-subscription',
              release  => "${::lsbdistcodename}",
            }
				  }
        }
        
      }
      'Ubuntu': {
        if($basesys::aptly_mirror != ''){
          apt::source { 'aptly-mirror':
              comment  => "Aptly mirror ${basesys::aptly_mirror}",
              location => "http://${basesys::repo_url}/ubuntu/${basesys::aptly_mirror}",
              repos    => 'main',
          }
        }else{
          apt::source { 'ubuntu-upr':
              comment  => 'Ubuntu UPR repo',
              location => "http://${basesys::repo_url}/ubuntu",
              repos    => 'main universe multiverse',
          }

          apt::source { 'ubuntu-security':
            comment  => 'repos.upr.edu.cu-${::lsbdistcodename}-security',
            location => "http://${basesys::repo_url}/ubuntu",
            repos    => 'main universe multiverse restricted',
            release  => "${::lsbdistcodename}-security",
          }

          apt::source { 'ubuntu-updates':
            comment  => 'repos.upr.edu.cu-${::lsbdistcodename}-updates',
            location => "http://${basesys::repo_url}/ubuntu",
            repos    => 'main universe multiverse restricted',
            release  => "${::lsbdistcodename}-updates",
          }

          apt::source { 'ubuntu-backports':
            comment  => 'repos.upr.edu.cu-${::lsbdistcodename}-backports',
            location => "http://${basesys::repo_url}/ubuntu",
            repos    => 'main universe multiverse restricted',
            release  => "${::lsbdistcodename}-backports",
          }
         
          apt::source { 'icinga':
              comment  => 'Icinga UPR',
              #location => 'http://repos.upr.edu.cu/icinga/ubuntu/',
              location => 'http://packages.icinga.com/ubuntu/',
              repos    => 'main',
              release  => "icinga-${::lsbdistcodename}",
              key      => {
                'id'     => 'F51A91A5EE001AA5D77D53C4C6E319C334410682',
                #'source' => 'http://repos.upr.edu.cu/icinga/icinga.key',
                'source' => 'http://packages.icinga.com/icinga.key',
              }

          }
        }
      }
# lint:ignore:80chars
      'RedHat', 'CentOS': {
        yumrepo {
          "base-${::operatingsystemmajrelease}":
            descr     => "base ${::operatingsystemmajrelease} server rpms",
            name      => "base-${::operatingsystemmajrelease}-server-rpms",
            enabled   => '1',
            sslverify => '0',
            gpgcheck  => '0',
	          baseurl   => "http://repos.upr.edu.cu/CentOS/${::operatingsystemmajrelease}/os/${::architecture}"
          ;
          "updates-${::operatingsystemmajrelease}-server-updates-rpms":
            descr     => "updates ${::operatingsystemmajrelease} server updates rpms",
            name      => "updates-${::operatingsystemmajrelease}-server-updates-rpms",
            enabled   => '1',
            sslverify => '0',
            gpgcheck  => '0',
            baseurl   => "http://repos.upr.edu.cu/CentOS/${::operatingsystemmajrelease}/updates/${::architecture}"

          ;
          "extras-${::operatingsystemmajrelease}-server-extra-rpms":
            descr     => "extras ${::operatingsystemmajrelease} server extra rpms",
            name      => "extras-${::operatingsystemmajrelease}-server-extra-rpms",
            enabled   => '1',
            sslverify => '0',
            gpgcheck  => '0',
	          baseurl   => "http://repos.upr.edu.cu/CentOS/${::operatingsystemmajrelease}/extras/${::architecture}"
          ;
           "centosplus-${::operatingsystemmajrelease}-server-centosplus":
            descr     => "centosplus ${::operatingsystemmajrelease} server centosplus",
            name      => "centosplus-${::operatingsystemmajrelease}-server-centosplus",
            enabled   => '1',
            sslverify => '0',
            gpgcheck  => '0',
            baseurl   => "http://repos.upr.edu.cu/CentOS/${::operatingsystemmajrelease}/centosplus/${::architecture}"
          ;
           "icinga-${::operatingsystemmajrelease}-server-icinga2":
            descr     => "icinga2 ${::operatingsystemmajrelease} server icinga2",
            name      => "icinga2-${::operatingsystemmajrelease}-server-icinga2",
            enabled   => '1',
            sslverify => '0',
            gpgcheck  => '0',
            baseurl   => "http://repos.upr.edu.cu/icinga/epel/${::operatingsystemmajrelease}/release/"
          #;

          #'epel':
            #descr          => "Extra Packages for Enterprise Linux ${::operatingsystemmajrelease}",
            #name           => 'epel',
            #mirrorlist     => "https://mirrors.fedoraproject.org/metalink?repo=epel-${::operatingsystemmajrelease}&arch=x86_64",
            #failovermethod => priority,
            #enabled        => '1',
            #gpgcheck       => '0',
        }
      }
# lint:endignore
      default: {}
    }

    # Backports enabled or not
    if($basesys::backports_enabled){
      if($::osfamily == 'Debian'){
        include '::apt::backports'
      }
    }

    if($basesys::puppet_enabled){
      if($::osfamily == 'Debian'){
        # Install Puppetlabs PC1 jessie Source Repository
        ::apt::source { 'puppet-agent':
          comment  => "Puppetlabs PC1 ${::lsbdistcodename} Repository from basesys",
          # location => 'http://repos.upr.edu.cu/puppet5/apt/',
          location => 'https://apt.puppetlabs.com/',
          repos    => 'main',
          #key      => {
           #id     => '47B320EB4C7C375AA9DAE1A01054B7A24BD6EC30',
           #server => 'pgp.mit.edu',
          #},
        }
      }
    } # end basesys::puppet_enabled
  } # end basesys::repos_enabled
