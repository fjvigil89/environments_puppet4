# Class: casserver
# ===========================
#
#
class casserver {

 class { 'cas': 
   server_name        => 'http://cas.upr.edu.cu',
   ldap_url           => 'ldap://10.2.24.35',
   ldap_base_dn       => 'DC=upr,DC=edu,DC=cu',
   ldap_search_filter => 'cn={sAMAccountName}'
 }
}
