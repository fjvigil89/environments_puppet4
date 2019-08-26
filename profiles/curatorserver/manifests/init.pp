# Class: curatorserver
# ===========================
# Copyright 2019 Your name here, unless otherwise noted.
#
class curatorserver {

  curator::action { 'purge_logstash_over_45_days':
    config_path =>  '/etc/curator',
    entities => {
      1 => {
        'action' => 'delete_indices',
       'description' => 'Delete indices older than 45 days (based on index name)',
       'options' => {
         'continue_if_exception' => 'True',
         'disable_action'        => 'False',
         'ignore_empty_list'     => 'True',
       },
       'filters' => [
         {
           'filtertype' => 'pattern',
           'kind'       => 'prefix',
           'value'      => 'proxy-',
         },
         {
           'filtertype' => 'age',
           'source'     => 'name',
           'direction'  => 'older',
           'timestring' => '%Y.%m.%d',
           'unit'       => 'days',
           'unit_count' => '45',
         },
       ],
      },
    },
  }

  curator::job { 'purge_logstash_over_45_days_everyday':
   action => 'purge_logstash_over_45_days',
   minute => 0,
   hour   => 2,
  }

}
