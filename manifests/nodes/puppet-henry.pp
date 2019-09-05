node 'puppet-henry.upr.edu.cu' {
  package { 'lsb-release':
          ensure => installed,
  }~>
  include puppetdevserver
}
