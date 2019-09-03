################################
#
# Gitlab Server Class
################################
#
class gitlabserver {
  include git
  class { 'gitlab':
    external_url          => 'http://gitlab.upr.edu.cu',
    skip_auto_reconfigure => 'present',
    skip_auto_migrations  => false,
    #pgpass_file_ensure   => 'present',
    #pgbouncer_password   => 'YourPassword',
    backup_cron_enable    => true,
    nginx                 => {
      redirect_http_to_https  => false
    },
    unicorn               => {
      'worker_processes' => 3,
      'worker_timeout'   => 60,
    },
    sidekiq               => {
      'shutdown_timeout' => 2,
    },
    gitlab_rails          => {
       'webhook_timeout'                   => 5,
       'gitlab_default_theme'              => 2,
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
          group_base                    => 'OU=_Usuarios,DC=upr,DC=edu,DC=cu',
        }

    },
  },
  logging      => {
    'svlogd_size' => '200 * 1024 * 1024',
    }, 
  }
}
