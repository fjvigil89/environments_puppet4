# Class: casserver
# ===========================
#
#
class casserver {

 class { 'cas': 
   server_name           => 'http://cas.upr.edu.cu',
   ldap_url              => 'ldap://10.2.24.35',
   ldap_root_dn          => 'DC=upr,DC=edu,DC=cu',
   ldap_base_dn          => 'DC=upr,DC=edu,DC=cu',
   ldap_manager_dn       => 'CN=Administrator,CN=Users,DC=upr,DC=edu,DC=cu',
   ldap_manager_password => 'mistake*ad.20',
   ldap_domain           => 'upr.edu.cu',
   # ldap_search_filter    => 'cn={sAMAccountName}',
 }
 cas::service { 'Gitlab':
    service_id  => '^https://cas.upr.edu.cu.+gitlab.+',
    id          => '100',
    enabled     => true,
    sso_enabled => true,
  },
}
