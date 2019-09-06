node 'ansible.upr.edu.cu' {  
  package { 'lsb-release':
          ensure => installed,
  }
  class { '::basesys':
    uprinfo_usage   => 'servidor ansible',
    application     => 'Ceph',
    proxmox_enabled => false,
    repos_enabled   => true,
    mta_enabled     => false,
  }

 
# Here is a controller node.  You could have more than one, if you like.
  include ansible::controller
  include ansible::target      # Just like Puppet masters also have agents.
  include mysql::server
# Here are three of my web servers.
  include apache
  ansible::add_to_group { 'webservers': }

# My production databases have a predictable naming scheme.
  ansible::add_to_group { 'production': }
  ansible::add_to_group { 'databases': }

# Development databases have similarly predictable names.
  include mysql::client
  ansible::add_to_group { 'development': }
  ansible::add_to_group { 'databasess': }
 




}
