# Class: letsencrypt_host::install
# ===========================
#
# install configuratie.

class letsencrypt_host::install {
  if ($::letsencrypt_host::email){
    class { '::letsencrypt':
      email => $::letsencrypt_host::email,
    }
  }
  else {
    class { '::letsencrypt':
      unsafe_registration => true,
    }
  }
  if($::letsencrypt_host::webroot_enable) {
    each($::letsencrypt_host::dominios)|Integer $index, String $value|{
      letsencrypt::certonly { "${value}":
        domains       => [$value],
        plugin        => $::letsencrypt_host::plugin,
        webroot_paths => $::letsencrypt_host::webroot_paths
        manage_cron => true,
        cron_before_command => 'service nginx stop',
        cron_success_command => '/bin/systemctl reload nginx.service',
        suppress_cron_output => true,
      }
    }
  }
  else {
    each($::letsencrypt_host::dominios)|Integer $index, String $value|{
      letsencrypt::certonly { "${value}":
        domains => [$value],
        plugin  => $::letsencrypt_host::plugin,
        manage_cron => true,
        cron_before_command => 'service nginx stop',
        cron_success_command => '/bin/systemctl reload nginx.service',
        suppress_cron_output => true,
      }
    }
  }
}

