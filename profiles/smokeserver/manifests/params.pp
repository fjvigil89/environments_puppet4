# Class: smokeserver::params
#
#
class smokeserver::params {
  $owner          = 'SysAdmin'
  $mode           = 'standalone'
  $cgiurl         = 'http://10.2.1.18/cgi-bin/smokeping.cgi'
  $probes         = [ { name => 'FPing', binary => '/usr/bin/fping', step => '300' } ]
  # $contact            = 'upredes@upr.edu.cu'
  # $mailhost           = 'my.mail.host'
  # $syslogfacility     = 'local0'
  # $syslogpriority     = 'info'

  $cgi_remark_top     = 'Bienvenidos al sitio SmokePing de la UPR.'
  $cgi_title_top      = 'Gráficos de latencia de nuestra red.'
  $alerts_to          = 'upredes@upr.edu.cu'
  $alerts_from        = 'upredes@upr.edu.cu'
  $alerts             = [
    {
      name        => 'bigloss',
      alert_type  => 'loss',
      pattern     => '==0%,==0%,==0%,==0%,>0%,>0%,>0%',
      comment     => 'De repente hay pérdida de paquetes',
    },
    {
      name        => 'startloss',
      alert_type  => 'loss',
      pattern     => '==S,>0%,>0%,>0%',
      comment     => 'Pérdida en el inicio',
    },
    {
      name        => 'noloss',
      alert_type  => 'loss',
      pattern     => '>0%,>0%,>0%,==0%,==0%,==0%,==0%',
      edgetrigger => true,
      comment     => 'Hubo pérdida y ahora es alcanzable de nuevo',
    },
  ]
  # $servername        = 'smokeping.upr.edu.cu'
  # $manage_apache     = true
  $target            = []
  $menu              = []
  $pagetitle         = []
  $hierarchy_parent  = []
  $hierarchy_level   = []
  $host              = []
}
