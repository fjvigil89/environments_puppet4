node 'jitsi.upr.edu.cu' { 
class { 'jitsimeet':
    jitsi_domain         => 'jitsi.upr.edu.cu',
    manage_certs         => true,
    jitsi_vhost_ssl_key  => '/etc/letsencrypt/live/jitsi.upr.edu.cu/privkey.pem',
    jitsi_vhost_ssl_cert => '/etc/letsencrypt/live/jitsi.upr.edu.cu/cert.pem',
    auth_vhost_ssl_key   => '/etc/letsencrypt/live/auth.jitsi.upr.edu.cu/privkey.pem',
    auth_vhost_ssl_cert  => '/etc/letsencrypt/live/auth.jitsi.upr.edu.cu/cert.pem',
    jvb_secret           => 'mysupersecretstring',
    focus_secret         => 'anothersupersecretstring',
    focus_user_password  => 'yetanothersecret',
  }
}
