# Class: cephserver
# ===========================
# Copyright 2019 Your name here, unless otherwise noted.
#
class cephserver {

  class {'ceph':
    mon_hosts   => [ 'cephUPR0.upr.edu.cu','cephUPR1.upr.edu.cu','cephUPR2.upr.edu.cu'],
    release     => 'nautilus',
    cluster_net => '10.2.3.0/24',
    public_net  => '10.2.3.0/24',
  }


}
