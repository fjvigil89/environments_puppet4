# class monitoring::icinga2_agent
#
#============================
#
# Configure icinga2_agent

class monitoring::icinga2_agent(
  $manage_repo = true,
) {

 class {'::icinga2':
  manage_repo => $manage_repo,
 }

 include ::icinga2::feature::api

 icinga2::object::zone { 'global-templates':
  global => true,
 }

 icinga2::object::zone { 'director-global':
  global => true,
 }
 class { '::icinga2::feature::api':
  pki             => 'icinga2',
  #ticket_salt     => '5a3d695b8aef8f18452fc494593056a4',
  accept_config   => true,
  accept_commands => true,
  zones           => {
     'NodeName'   => {
      'endpoints' => ['NodeName'],
      'parent'    =>   'master',
    },
    'master' =>   {}
  }
 }
}
