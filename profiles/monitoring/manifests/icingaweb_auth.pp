#
# Class monitoring::icingaweb_auth
#==================================
#
# Configure monitoring::icingaweb_auth

class monitoring::icingaweb_auth {
#Configure Resourse Authentication
icingaweb2::config::resource {'ad-upr':
  type            =>  'ldap',
  host            =>  'ad.upr.edu.cu',
  port            =>  389,
  ldap_root_dn    =>  $monitoring::ad_base_dn,
  ldap_bind_dn    =>  $monitoring::ad_bind_dn,
  ldap_bind_pw    =>  $monitoring::ad_bind_pw,
  ldap_encryption =>  'none',
}

# Configure Autentication Method
icingaweb2::config::authmethod { 'ad-auth':
  backend  => 'msldap',
  resource => 'ad-upr',
  order    => '02',
}

#Configure Manage Group Backends
icingaweb2::config::groupbackend { 'ad-group-backend':
  backend  => 'msldap',
  resource => 'ad-upr',
}

#Manage Roles
icingaweb2::config::role { 'SysAdmins':
  users       => 'icingaadmin, arian, frank.vigil, rene, ymtnez, henry.fleitas, yandy',
  groups      => 'SysAdmins',
  permissions => '*',
}

icingaweb2::config::role { 'Develops':
  users       => 'irlenys.ibarra, manuel.diaz, osmay, serrano',
  groups      => 'Develops',
  permissions => 'module/monitoring, module/doc',
}
}


