# Class: commun_ssh_keys
# ===========================
#
class commun_ssh_keys {


  #Copy SSH Key
file { '/root/.ssh/id_rsa':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0600',
  source => 'puppet:///modules/commun_ssh_keys/ssh_keys/id_rsa',
}

file { '/root/.ssh/id_rsa.pub':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => 'puppet:///modules/commun_ssh_keys/ssh_keys/id_rsa.pub',
}

file { '/root/.ssh/config':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => 'puppet:///modules/commun_ssh_keys/ssh_keys/config',
}


}
