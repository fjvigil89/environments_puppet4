################################
#
# Gitlab Server Class
################################
#
class gitlabserver{
  include git
  class { 'gitlab':
    external_url         => 'http://gitlab.upr.edu.cu',
    skip_auto_migrations => true,
    nginx                => {
      redirect_http_to_https  => true
    },
    gitlab_rails         => {
      'webhook_timeout'      => 10,
      'gitlab_default_theme' => 2,
      'ldap_enabled'         => true,
      'ldap_servers'         => {
        'main' => {
          label                         => 'LDAP',
          host                          => 'ad.upr.edu.cu',
          port                          => 389,
          uid                           => 'sAMAccountName',
          method                        => 'plain',
          bind_dn                       => 'CN=git,OU=_Servicios,DC=upr,DC=edu,DC=cu',
          password                      => 'mistake*tig.20',
          active_directory              => true,
          allow_username_or_email_login => false,
          block_auto_created_users      => false,
          base                          => 'DC=upr,DC=edu,DC=cu',
        }
      },
  },
  logging      => {
    'svlogd_size' => '200 * 1024 * 1024',
    }, 
    secrets      => {
      'gitlab_shell' => {
        secret_token    => 'asecrettoken1234567890'},
        'gitlab_rails' => {
          secret_token => 'asecrettoken123456789010'},
          'gitlab_ci'  => {
            secret_token    => null,
            secret_key_base => 'asecrettoken123456789011',
            db_key_base     => 'asecrettoken123456789012',
          }
    },

}
}
