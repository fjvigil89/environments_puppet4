# Class: basesys::repos
# ===========================
#
# repos configuratie.  repos
#
class basesys::repos (
){

  if($basesys::repos_enabled){

    # Debian/Ubuntu heeft specifieke module nodig.
    # Rhel based OS kan gewoon yum resource gebruiken.
    if($::osfamily == 'Debian') {
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
      # Uitzondering toevoegen voor apt-transport-https om dependentie loops te voorkomen
      Class['apt::update'] -> Package <| title != 'apt-transport-https' |>

      # apt-https-transport toevoegen
      #(In debian 10/ubuntu 18.04 is dit niet meer nodig, maar wel als dummy package beschikbaar)
      # Beheerd door de Apt module vanaf versie 4.4.0
      ensure_packages(['apt-transport-https'], {
        ensure=> installed,
      })
    }

    # Debs repository met packages gemaakt/gehost op UGent
    case $::osfamily{
      'Debian': {
        apt::source{
          'debs':
            comment  => 'UGent debs repo',
            location => 'http://debs.ugent.be/debian',
            repos    => 'main',
        }
      }
      'RedHat': {
        yumrepo {
          'debs-ugent':
            descr    => 'UGent RHEL repo',
            name     => 'debs-ugent',
            gpgcheck => '0',
            enabled  => '1',
            baseurl  => "http://debs.ugent.be/rhel/${::operatingsystemmajrelease}";
        }
      }
      default: {}
    }

    # OS repos, bij Debian based houden we rekening met aptly_mirror variable
    case $::operatingsystem{
      'Debian': {
        if($basesys::aptly_mirror != ''){
          apt::source{
            'aptly-mirror':
              comment  => "Aptly mirror ${basesys::aptly_mirror}",
              location => "http://debs.ugent.be/aptly/${basesys::aptly_mirror}",
              repos    => 'main',
          }
        }else{
          apt::source{
            'debian-de':
              comment  => 'Debian DE repo',
              location => 'http://ftp.de.debian.org/debian',
              repos    => 'main non-free contrib',
          }
          apt::source{
            'debian-security':
              comment  => 'Debian Security repo',
              location => 'http://security.debian.org/',
              repos    => 'main non-free contrib',
              release  => "${::lsbdistcodename}/updates",
          }
        }
      }
      'Ubuntu': {
        if($basesys::aptly_mirror != ''){
          apt::source{
            'aptly-mirror':
              comment  => "Aptly mirror ${basesys::aptly_mirror}",
              location => "http://debs.ugent.be/aptly/${basesys::aptly_mirror}",
              repos    => 'main',
          }
        }else{
          apt::source{
            'ubuntu-de':
              comment  => 'Ubuntu DE repo',
              location => 'http://be.archive.ubuntu.com/ubuntu',
              repos    => 'main universe multiverse',
          }

          apt::source { "be.archive.ubuntu.com-${::lsbdistcodename}-security":
            location => 'http://be.archive.ubuntu.com/ubuntu',
            repos    => 'main universe multiverse restricted',
            release  => "${::lsbdistcodename}-security",
          }
        }
      }
# lint:ignore:80chars
      'RedHat', 'CentOS': {
        yumrepo {
          "UPSTREAM-rhel-${::operatingsystemmajrelease}-server-rpms":
            descr     => "UPSTREAM rhel ${::operatingsystemmajrelease} server rpms",
            name      => "UPSTREAM-rhel-${::operatingsystemmajrelease}-server-rpms",
            enabled   => '1',
            sslverify => '0',
            gpgcheck  => '0',
            baseurl   => "https://pulp2.ugent.be/pulp/repos/rhelupstream/rhel/server/${::operatingsystemmajrelease}/x86_64/os",
          ;
          "UPSTREAM-rhel-${::operatingsystemmajrelease}-server-optional-rpms":
            descr     => "UPSTREAM rhel ${::operatingsystemmajrelease} server optional rpms",
            name      => "UPSTREAM-rhel-${::operatingsystemmajrelease}-server-optional-rpms",
            enabled   => '1',
            sslverify => '0',
            gpgcheck  => '0',
            baseurl   => "https://pulp2.ugent.be/pulp/repos/rhelupstream/rhel/server/${::operatingsystemmajrelease}/x86_64/optional",
          ;
          "UPSTREAM-rhel-${::operatingsystemmajrelease}-server-extra-rpms":
            descr     => "UPSTREAM rhel ${::operatingsystemmajrelease} server extra rpms",
            name      => "UPSTREAM-rhel-${::operatingsystemmajrelease}-server-extra-rpms",
            enabled   => '1',
            sslverify => '0',
            gpgcheck  => '0',
            baseurl   => "https://pulp2.ugent.be/pulp/repos/rhelupstream/rhel/server/${::operatingsystemmajrelease}/x86_64/extras",
          ;
          'epel':
            descr          => "Extra Packages for Enterprise Linux ${::operatingsystemmajrelease}",
            name           => 'epel',
            mirrorlist     => "https://mirrors.fedoraproject.org/metalink?repo=epel-${::operatingsystemmajrelease}&arch=x86_64",
            failovermethod => priority,
            enabled        => '1',
            gpgcheck       => '0',
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
        ::apt::source { 'puppetlabs-pc1-agent':
          comment  => "Puppetlabs PC1 ${::lsbdistcodename} Repository uit basesys",
          location => 'http://apt.puppetlabs.com',
          repos    => 'PC1',
          key      => {
            id     => '47B320EB4C7C375AA9DAE1A01054B7A24BD6EC30',
            server => 'pgp.mit.edu',
          },
        }
      }
    } # end basesys::puppet_enabled
  } # end basesys::repos_enabled
}
