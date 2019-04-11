class monitoring::icingaweb_elasticsearch {
  class { 'icingaweb2::module::elasticsearch':
    git_revision => 'master',
    instances    => {
      'elastic'  => {
      uri      => 'http://elk.upr.edu.cu:80',
      user     => 'kibanaadmin',
      password => '$*uprP@ssword*$',
    }
  },
  eventtypes   => {
    'filebeat' => {
      instance => 'elastic',
      index    => 'filebeat-*',
      filter   => 'beat.hostname={host.name}',
      fields   => 'input_type, source, message',
    }
  }
  }
}
