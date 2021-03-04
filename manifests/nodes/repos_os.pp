node 'repos.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }~>
  class {'reposserver':;}


}
