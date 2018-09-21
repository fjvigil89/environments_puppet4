# Class: sambarepos_server
# ===========================
#
class sambarepos_server (
  Array[String] $shares_name = $::sambarepos_server::params::shares_name,
  Array[String] $valid_users = $::sambarepos_server::params::valid_users,
  String $path_nfs          = $::sambarepos_server::params::path_nfs, 
)inherits sambarepos_server::params {


  class { '::samba_client':
    shares_name => $::sambarepos_server::shares_name,
    valid_users => $::sambarepos_server::valid_users,
    path_nfs    => $::sambarepos_server::path_nfs,
  }
  
  class { '::apache':
    default_vhost => false,
    mpm_module    => 'prefork',
  }
  $shares_name.each |Integer $index, String $value|{
    apache::vhost { "repo_${value}.upr.edu.cu non-ssl":
      servername    => "repo_${value}.upr.edu.cu",
      serveraliases => ["www.repo_${value}.upr.edu.cu"],
      port          => '80',
      docroot       => "${path_nfs}${value}",
      docroot_owner => 'root',
      docroot_group => 'users',
      directories   => [ {
        'path'           => "${path_nfs}${value}",
        'options'        => ['Indexes','FollowSymLinks','MultiViews'],
        'allow_override' => 'All',
        'directoryindex' => 'index.php',
        },],
        redirect_status  => 'permanent',
        redirect_dest    => "https://repo_${value}.upr.edu.cu/",
     }~>
     apache::vhost { "repo_${value}.upr.edu.cu ssl":
       servername    => "repo_${value}.upr.edu.cu",
       serveraliases =>  ["www.repo_${value}.upr.edu.cu"],
       port          => '443',
       docroot       => "${path_nfs}${value}",
       docroot_owner => 'root',
       docroot_group => 'users',
       ssl           => true,
       directories =>  [ {
         'path'           => "${path_nfs}${value}",
         'options'        => ['Indexes','FollowSymLinks','MultiViews'],
         'allow_override' => 'All',
         'directoryindex' => 'index.php',
         },],
     }
  }


}
