# Class: letsencrypt_host::install
# ===========================
#
# install configuratie.

class letsencrypt_host::install {
  
 class { '::letsencrypt':
  email => $::letsencrypt_host::email,
 }

 if($::letsencrypt_host::webroot_enable) {
   letsencrypt::certonly { 'foo':
      domains       => $::letsencrypt_host::dominios,
      plugin        => $::letsencrypt_host::plugin,
      webroot_paths => $::letsencrypt_host::webroot_paths
  }
 }
 else{
    letsencrypt::certonly { 'foo':
      domains => $::letsencrypt_host::dominios,
     plugin   => $::letsencrypt_host::plugin,
  }
 }
  
}
