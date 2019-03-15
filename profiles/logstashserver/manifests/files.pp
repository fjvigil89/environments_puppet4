
define logstashserver::file (
  $filtros     = [],
  $owner       = 'root',
  $zonedir     ='/etc/logstash/conf.d',
  $mode        = '0644',
  $dirmode     = '0750',
  $group       = 'root',
  $source      = undef,
  $source_base = 'puppet:///modules/logstashserver/',
  $content     = undef,
  $ensure      = 'file',
){

  }
  if $source      { $zone_source = $source }
  if $source_base { $zone_source = "${source_base}${title}" }


  if ! defined(File[$zonedir]) {
    file { $zonedir:
      ensure => directory,
      owner  => $owner,
      group  => $group,
      mode   => $dirmode,
    }
  }
  file { "${zonedir}/${title}":
    ensure  => $ensure,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    source  => $zone_source,
    content => $content,
    notify  => Class ['::logstashserver::service'],
  }

}
