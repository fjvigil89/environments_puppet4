# Class: gitlab_runner
# ===========================
# Author Name <author@domain.com>
# Copyright 2019 Your name here, unless otherwise noted.
#
class gitlab_runner {
class {'gitlab_ci_multi_runner': 
    nice => '15'
}


gitlab_ci_multi_runner::runner { "dns.upr.edu.cu":
    gitlab_ci_url => 'http://gitlab.upr.edu.cu',
    tags          => ['dns'],
    token         => 'sUayR-NyGG69by2G4viT'
    executor      => 'ssh',
    ssh_host      => 'gitlab.upr.edu.cu',
    ssh_port      => 22,
    ssh_user      => 'root',
    ssh_password  => 'gitlab.upr.edu.cu'
}


}
