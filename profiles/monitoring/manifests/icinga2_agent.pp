# class monitoring::icinga2_agent
#
#============================
#
# Configure icinga2_agent
#

class monitoring::icinga2_agent(
  $manage_repo = true,
) {

 class {'::icinga2':
  manage_repo => $manage_repo,
  confd       =>  'example.d',
  features    => ['checker','mainlog'],
 }


 icinga2::object::zone { 'global-templates':
  global => true,
 }

 icinga2::object::zone { 'director-global':
  global => true,
 }
 include ::monitoring::checks
 class { '::icinga2::feature::api':
  pki             => 'icinga2',
  accept_config   => true,
  accept_commands => true,
  zones           => {
    'NodeName' => {
     'endpoints' => ['NodeName'],
     'parent'    =>   'master',
    },
    'master' => {
     'endpoints' => ['master-icinga0.upr.edu.cu'],
    }
  }
 }
 include icinga2_conf
}
