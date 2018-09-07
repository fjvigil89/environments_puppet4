# Class: casserver
# ===========================
#
#
class casserver {

  class { "tomcat":
    version => "7"
  } ->
  tomcat::instance { "cas":
    ensure => present,
    server_port => "8006",
    http_port => "8081",
    ajp_port => "8010"
  } 

  include apache
  include apache::mod::ssl
  include apache::mod::proxy
  include apache::mod::proxy_ajp

  openssl::certificate::x509 { $::fqdn:
    ensure => present,
    country => "CU",
    organization => "UPR",
    commonname => $::fqdn,
    days => "3650",
    force => false,
    cnf_tpl => "openssl/cert.cnf.erb",
    base_dir => "/etc/ssl/certs"
  } ->

  apache::vhost { $::fqdn:
    port => "443",
    ssl => true,
    ssl_key => "/etc/ssl/certs/${::fqdn}.key",
    ssl_cert => "/etc/ssl/certs/${::fqdn}.crt",
    docroot => "/var/www",
    proxy_pass => [
        { path => "/cas", url => "ajp://localhost:8010/cas" }
    ]
  }

  class { "cas::server":
    group     => 'root',
    war       => "/srv/cas-maven/target/cas.war",
    deploy_to => "$tomcat::instance_basedir/cas/webapps/cas.war",
    ldap_url  => "ldap://ad.upr.edu.cu",
   # ldap_trustedcert => "/path/to/your.ldap.crt",
    ldap_basedn => "dc=upr,dc=edu,dc=cu",
    ldap_managerdn => "cn=Administrator,dc=upr,dc=edu,dc=cu",
    ldap_managerpassword => "mistake*ad.20",
    ldap_searchfilter => "(uid={user})",
    require => Tomcat::Instance["cas"]
  }

}
