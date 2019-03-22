# Class: letsencrypt_host::install
# ===========================
#
# install configuratie.

class letsencrypt_host::install {
  #if ($::letsencrypt_host::email){
  #  class { '::letsencrypt':
  #    email      => $::letsencrypt_host::email,
  #  }
  #}
  #else {
    class { '::letsencrypt':
      unsafe_registration => true,
    }
    #}
  if($::letsencrypt_host::host::webroot_enable) {
    #each($::letsencrypt_host::host::dominios)|Integer $index, String $value|{
      letsencrypt::certonly { "${::letsencrypt_host::host::dominios}":
        domains       => [$::letsencrypt_host::host::dominios],
        plugin        => $::letsencrypt_host::host::plugin,
        webroot_paths => $::letsencrypt_host::host::webroot_paths,
      }
      #}
  }
  else {
    #each($::letsencrypt_host::host::dominios)|Integer $index, String $value|{
      letsencrypt::certonly { "lolo":        
        domains    => [$::letsencrypt_host::host::dominios],
        plugin     => $::letsencrypt_host::host::plugin,
      }
      #}
  }
}

