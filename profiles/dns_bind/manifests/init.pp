# Class: dns_bind
# ===========================
# 
# Full description of class dns_bind here.
#
class dns_bind {
  class { '::bind': chroot =>  true }
}
