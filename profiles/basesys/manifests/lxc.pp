#class: basesys::lxc
# ===========================
#
# Configure LimitNPROC in to lxc systemd.conf

class basesys::lxc {
  if($::virtual == 'lxc') {
    $service_limit = '
    [Service]
     LimitNPROC=infinity'
    file_line { 'ServiceLimit':
    ensure                                => absent,
    path                                  => '/etc/systemd/system.conf',
    line                                  => $service_limit,
    replace                               => true,
    after                                 => '^# See systemd-system.conf(5) for details.',
    match_for_absence                     => true,
    replace_all_matches_not_matching_line => true,

  }
}
}
