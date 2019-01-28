# Class: letsencrypt_host::install
# ===========================
#
# install configuratie.

class letsencrypt_host::install {
  if ($::letsencrypt_host::email){
    class { '::letsencrypt':
      email      => $::letsencrypt_host::email,
      config_dir => '/tmp/letsencrypt',
    }
  }
  else {
    class { '::letsencrypt':
      unsafe_registration => true,
      config_dir          => '/tmp/letsencrypt',
    }
  }
  if($::letsencrypt_host::webroot_enable) {
    each($::letsencrypt_host::dominios)|Integer $index, String $value|{
      letsencrypt::certonly { "${value}":
        domains       => [$value],
        plugin        => $::letsencrypt_host::plugin,
        webroot_paths => $::letsencrypt_host::webroot_paths,
        config_dir    => '/tmp/letsencrypt',
      }
    }
  }
  else {
    each($::letsencrypt_host::dominios)|Integer $index, String $value|{
      letsencrypt::certonly { "${value}":
        domains    => [$value],
        plugin     => $::letsencrypt_host::plugin,
        config_dir => '/tmp/letsencrypt',
      }
    }
  }
}

