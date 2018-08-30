# Class: basesys::swap
# ===========================
#
#
class basesys::swap(){
	sysctl::configuration { 'vm.swappiness':
	  ensure => absent
	}
}
