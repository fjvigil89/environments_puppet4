# Class: letsencrypt_host::install
# ===========================
#
# install configuratie.

class letsencrypt_host::install {
  if ($::letsencrypt_host::email){
    class { '::letsencrypt':
      email      => $::letsencrypt_host::email,
      config_dir => $::letsencrypt_host::config_dir,
    }
  }
  else {
    class { '::letsencrypt':
      unsafe_registration => true,
      config_dir          => $::letsencrypt_host::config_dir,
    }
  }
  if($::letsencrypt_host::webroot_enable) {
    each($::letsencrypt_host::dominios)|Integer $index, String $value|{
      letsencrypt::certonly { "${value}":
        domains       => [$value],
        plugin        => $::letsencrypt_host::plugin,
        webroot_paths => $::letsencrypt_host::webroot_paths,
        config_dir    => $::letsencrypt_host::config_dir,
      }
    }
  }
  else {
   notify{'node_inclusion':
    message =>  $::letsencrypt_host::config_dir,
  }
    each($::letsencrypt_host::dominios)|Integer $index, String $value|{
      letsencrypt::certonly { "${value}":
        domains    => [$value],
        plugin     => $::letsencrypt_host::plugin,
        config_dir => $::letsencrypt_host::config_dir,
      }
    }
  }
}

