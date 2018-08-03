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

  Ssh_authorized_key <| title == 'frank' |>
  Ssh_authorized_key <| title == 'arian' |>

  $partial_hostname = regsubst($::fqdn, '\.upr\.edu\.cu$', '')
  if $partial_hostname == $::hostname {
    $host_aliases = [ $::ipaddress, $::hostname ]
  } else {
    $host_aliases = [ $::ipaddress, $::hostname, $partial_hostname ]
  }

  # Export hostkeys from all hosts.
  @@sshkey { $::fqdn:
    ensure       => present,
    host_aliases => $host_aliases,
    type         => 'rsa',
    key          => $::sshrsakey,
  }

  create_resources('sshkey', $known_hosts, { 'type' => 'rsa'})

# lint:ignore:140chars
  # Gebruik ssh-keyscan -t rsa gitlab.upr.edu.cu
  sshkey{ 'gitlab.upr.edu.cu':
    ensure       => present,
    host_aliases => 'gitlab',
    type         => 'ssh-rsa',
    key          => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQCxyXFBbBO+Ji2Zgs9/nFfg59nQIbg9z4Vp1Gqy1RBkorzsboMnbAxU8G8y5huGBQV1MjCmY69uUXvjFkVgQkCgra7CMg//2E+K0qiHP3XOa4AcGfOzM7ehNL9tvpA9zeBbI4/m5D78X5sErhAV38h29gfgrODyVkADOoAbtoKrgg/bnFLWHbiFSaFQTin8CyvNtnHEt5x6TWQK4u+ki3zO7MwMvLBXxK5YhfKZ2K9Cicrivczkbgs7uG1utunEVfwfMjB6s9/Yy2hfOBC7e1vk9eKrIFdeHFtW9L3qOsntP2Uxibs9eqgzvHSfSAgbIU+qRc1gAiaapRssUtXfWrCUXzYs9vkmSCM5JOtOsgYw2BoYE1uRuG2cb8DwV0CY4Fw8UesDeI4j5M6aOijm0tViDZQJrSrmJ01aJxswCUpUhuuU1gCyNBb3XjshrpEBKdTXgivpX/ytfeETjg414C1vRjEHeWHKBQCIKIkJWp71aO2tB6Fq9pz4WbNx9Y9y3pJdFwFZtLL6YrrszLLe9TV4FmZRh8WZ8G4Nc8Fh5Ky16B4UdH/+CX2BRDqABjFRpBPfEifAMa+yuiyJsiV5RZBx7dTn924AsT0JLHKNb34HPj3AyAPrqNsRZoHvVo+ci0qRjTq5OYI1wNp/dlIZ3WCKJm9NeCLqm+8G9H1rE9yiFQ';
  }

  @ssh_authorized_key {
    'root@gitlab.upr.edu.cu':
      ensure  => present,
      user    => 'root',
      type    => 'ssh-rsa',
      key     => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQCxyXFBbBO+Ji2Zgs9/nFfg59nQIbg9z4Vp1Gqy1RBkorzsboMnbAxU8G8y5huGBQV1MjCmY69uUXvjFkVgQkCgra7CMg//2E+K0qiHP3XOa4AcGfOzM7ehNL9tvpA9zeBbI4/m5D78X5sErhAV38h29gfgrODyVkADOoAbtoKrgg/bnFLWHbiFSaFQTin8CyvNtnHEt5x6TWQK4u+ki3zO7MwMvLBXxK5YhfKZ2K9Cicrivczkbgs7uG1utunEVfwfMjB6s9/Yy2hfOBC7e1vk9eKrIFdeHFtW9L3qOsntP2Uxibs9eqgzvHSfSAgbIU+qRc1gAiaapRssUtXfWrCUXzYs9vkmSCM5JOtOsgYw2BoYE1uRuG2cb8DwV0CY4Fw8UesDeI4j5M6aOijm0tViDZQJrSrmJ01aJxswCUpUhuuU1gCyNBb3XjshrpEBKdTXgivpX/ytfeETjg414C1vRjEHeWHKBQCIKIkJWp71aO2tB6Fq9pz4WbNx9Y9y3pJdFwFZtLL6YrrszLLe9TV4FmZRh8WZ8G4Nc8Fh5Ky16B4UdH/+CX2BRDqABjFRpBPfEifAMa+yuiyJsiV5RZBx7dTn924AsT0JLHKNb34HPj3AyAPrqNsRZoHvVo+ci0qRjTq5OYI1wNp/dlIZ3WCKJm9NeCLqm+8G9H1rE9yiFQ',
      #options => 'from="gitlab.upr.edu.cu,10.2.24.81"';
  }

# lint:endignore

}
