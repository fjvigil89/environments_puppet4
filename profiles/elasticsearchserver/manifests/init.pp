# Class: elasticsearchserver
# ===========================
# Copyright 2019 Your name here, unless otherwise noted.
#
class elasticsearchserver {


  class {'::elasticsearchserver::common':;}~>
  class {'::elasticsearchserver::service':;}->
  class {'::curatorserver':
    name        => ['purge_proxy_over_45_days','purge_apache_over_45_days'],
    descripcion => ['Delete indices proxy older than 45 days', 'Delete indices apache older than 45 days'],
    index       => ['proxy','apache'],
  }


}
