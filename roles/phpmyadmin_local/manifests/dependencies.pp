class phpmyadmin_local::dependencies
{
  $php = $phpmyadmin_local::params::php_version

    if $osfamily != 'Debian' {
        fail("Unsupported platform: ${osfamily}/${operatingsystem}")
    }
    require wget
    #phpmyadmin_local::secure::install {["php$php", "php$php-mysql","php$php-mcrypt"]:}
}
