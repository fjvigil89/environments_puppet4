# Class: librenmserver
# ===========================
#
class librenmserver {
  class { '::apache2::monit':
    monitor_email => 'henry.fleitas@upr.edu.cu',
  }
}
