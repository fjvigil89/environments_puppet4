# == Class curator::curatorserver
#
# This class is meant to be called from curator
# It sets variables according to platform
class curatorserver::params{
  $manage_repository    = false
  $name                 =['purge_logstash_over_45_days']
  $descripcion          =['Delete indices older than 45 days (based on index name)']
  $index                =['proxy']
}
