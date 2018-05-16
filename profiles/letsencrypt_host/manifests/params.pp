# Class: letsencrypt_host::params
# ===========================
#

# lint:ignore:80chars

 class letsencrypt_host::params {
  $dominios = ['upr.edu.cu'],
  $webroot_paths  = ['/var/www/upr.edu.cu'],
  $plugin = 'apache',
  $email = 'admin@upr.edu.cu',
}
