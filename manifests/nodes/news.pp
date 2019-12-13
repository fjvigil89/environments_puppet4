node 'news.upr.edu.cu' {
  package { 'lsb-release':
          ensure => installed,
  }
  class { '::basesys':
    uprinfo_usage  => 'servidor de noticias',
    application    => 'News server',
    repos_enabled  => false,
    mta_enabled    => false,

  }


}
