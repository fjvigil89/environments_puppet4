# Class: mysql_server::repo
# ===========================
class mysql_server::repo () inherits mysql_server::params {
# lint:ignore:140chars
  case $::osfamily {
    'Debian': {
      case $::mysql_server::provider {
        'percona': {
          apt::source { 'percona-apt-repo':
            location => 'http://repo.percona.com/apt/',
            release  => $::lsbdistcodename,
            repos    => 'main',
            key      => {
              'id'     => '4D1BB29D63D98E422B2113B19334A25F8507EFA5',
              'server' => 'keyserver.ubuntu.com',
            },
            include  => {
              'src' => false,
            },
          }

          # the base profile contains logic to choose either profile::apt or profile::yum
          Apt::Source['percona-apt-repo'] ~> Package['mysql_client']
          Apt::Source['percona-apt-repo'] ~> Package['percona-toolkit']
          Apt::Source['percona-apt-repo'] ~> Package['mysql-server']

        }
        default: {
          fail("There is no repo configured for provider ${$::mysql_server::provider} in mysql_server::repo profile")
        }
      }

    }
    default: {
      fail('This OS is not implemented in mysql_server profile')
    }
  }
  # lint:endignore
}
