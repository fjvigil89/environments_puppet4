# Class: elasticsearchserver
# ===========================
# Copyright 2019 Your name here, unless otherwise noted.
#
class elasticsearchserver {


  class {'::elasticsearchserver::common':;}~>
  class {'::elasticsearchserver::service':;}->
  class {'::curatorserver':
    nombre        => ['purge_proxy_over_6_month','purge_apache_over_6_month','purge_syslog_over_6_month'],
    descripcion => ['Delete indices proxy older than 182 days', 'Delete indices apache older than 182 days','Delete indices apache older than 182 days'],
    index       => ['proxy','apache','syslog'],
  }


}
