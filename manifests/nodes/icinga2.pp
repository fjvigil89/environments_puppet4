node 'master-icinga0.upr.edu.cu' {
 include icinga2_server
 package { 'lsb-release':
    ensure =>  installed,
 }
}
