node 'letscert.upr.edu.cu' {  
    class { '::basesys':
    uprinfo_usage  => 'Servidor lets encrypt',
    application    => 'lets encrypt',
    mta_enabled    => false,
  }
include ::apt
include ::apt::backports
apt::pin { 'stretch-backports-letsencrypt':
  release  => 'stretch-backports',
  packages => prefix(['acme', 'cryptography', 'openssl', 'psutil', 'setuptools', 'pyasn1', 'pkg-resources'], 'python-'),
  priority => 700,
}
class { ::letsencrypt:
  email => 'lets.encryptupr@gmail.com',
}
letsencrypt::certonly { 'upr':
 domains => ['contable.upr.edu.cu','sync.upr.edu.cu'],
 plugin  => 'apache',
}
}
