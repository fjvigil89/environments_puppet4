# Class: basesys::ssh
# ===========================
#
# Systemen public keys (knobbel)
# Sshkey wordt geexporteerd zodat we dit later kunnen gebruiken
#
#
class basesys::ssh(
  $known_hosts = {},
){

  # global_ssh_authorized_keys komen uit Hiera. zie common.yaml
  $global_ssh_authorized_keys = lookup('basesys::global_ssh_authorized_keys', {merge => hash, default_value => {}})
  create_resources('@ssh_authorized_key', $global_ssh_authorized_keys)

  Ssh_authorized_key <| title == 'root@gitlab' |>

  $partial_hostname = regsubst($::fqdn, '\.upr\.edu\.cu$', '')
  if $partial_hostname == $::hostname {
    $host_aliases = [ $::ipaddress, $::hostname ]
  } else {
    $host_aliases = [ $::ipaddress, $::hostname, $partial_hostname ]
  }

  # Export hostkeys from all hosts.
  if $::fqdn != 'ansible.upr.edu.cu'{
    @@sshkey { $::fqdn:
      ensure       => present,
      host_aliases => $host_aliases,
      type         => 'rsa',
      key          => $::sshrsakey,
    }
  }

  create_resources('sshkey', $known_hosts, { 'type' => 'rsa'})

  $global_ssh_known_host = lookup('basesys::global_ssh_known_host', {merge => hash, default_value => {}})
  create_resources('sshkey', $global_ssh_known_host)

  ::known_hosts::known_host { 'ceph.upr.edu.cu':
    user => 'ceph',
    type => 'ssh-rsa',
    key  => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDB6m46tCAnlxLIIxZGz75C075qPM+ahnXR5C6SRS+5p1vJYyP/fJP3vY8HV8R4Rq/xn6+IRf/QVxScnlLc8lRyV+fTBdE+iqYUX8mo8EwxPuhG1ft+/D3DAHToGts/o+jkG3+FPSH5qv4LncCRQKw6Zd08zDLoQja3SPZCz5z6kA2WUcZXfSJD6tbhbOfudCvHt5gRE+dC0pOwlXD14HLPEjLwdWDuN8eBs/HfIGVqXiwDzY/p6TjFeqsKuzbQL/a2DGi8paQglBNHAnlJNBG596VZS9vrldM0C+pEsG9pjP3edKhqoAMgpvIVI7BCnYH5MgDTkcu7RSIE1J7w/uf7 root@ceph',
  }

# lint:ignore:140chars
  # Gebruik ssh-keyscan -t rsa gitlab.upr.edu.cu
  #sshkey{ 'gitlab.upr.edu.cu':
  #  ensure       => present,
  #  host_aliases => 'gitlab',
  #  type         => 'ssh-rsa',
  #  key          => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDcODNgiShR6qzcgljO5TS64WWqelnn2rXJT7aORKeDU0TPYBZiqxnydLaMS1jlE2EBaACJac4oKVYxdZ9oKQOHdetL6KhJU0ORt1IpC7nwqxdHQ/5NT60+Rb7nDIdpHWYeXwSpCXSd1GNGsm0NJLckNZaq5Hl3VFxdwAwuQqqNVD2A861DfQE/+yQnu/ISuyO9rEarnLYeMkdlmTuL2MWub+9QVAYOzZHUZTr4/sHnZgaTfbGNoj0N+MX0bOwk8snYl7mQVSvmW5xqj5EL+t7ItSIvDhxnScGBpEY6f6wg2GDqUe48kfSMsV8PKiVSSa6d4nyE4UVmAVtgPEmX87Pj root@gitlab';
  #}

  #  @ssh_authorized_key {
  #  'root@gitlab.upr.edu.cu':
  #    ensure  => present,
  #    user    => 'root',
  #    type    => 'ssh-rsa',
  #    key     => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDcODNgiShR6qzcgljO5TS64WWqelnn2rXJT7aORKeDU0TPYBZiqxnydLaMS1jlE2EBaACJac4oKVYxdZ9oKQOHdetL6KhJU0ORt1IpC7nwqxdHQ/5NT60+Rb7nDIdpHWYeXwSpCXSd1GNGsm0NJLckNZaq5Hl3VFxdwAwuQqqNVD2A861DfQE/+yQnu/ISuyO9rEarnLYeMkdlmTuL2MWub+9QVAYOzZHUZTr4/sHnZgaTfbGNoj0N+MX0bOwk8snYl7mQVSvmW5xqj5EL+t7ItSIvDhxnScGBpEY6f6wg2GDqUe48kfSMsV8PKiVSSa6d4nyE4UVmAVtgPEmX87Pj root@gitlab', 
  #    options => 'from="gitlab.upr.edu.cu,10.2.24.81"';
  #}

# lint:endignore

}
