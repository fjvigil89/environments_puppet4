# Class: basesys::swap
# ===========================
#
#
class basesys::swap(){
	sysctl::configuration { 'vm.swappiness':
	  ensure => present,
	  value => '0',
	}
}
