# Class: letsencrypt_host::config
#===========================
#
# install configuratie.

class letsencrypt_host::config {
  class letsencrypt::config {
    config_dir => '/tmp/letsencrypt',
  }
}

