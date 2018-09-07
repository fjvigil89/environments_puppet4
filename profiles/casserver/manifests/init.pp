# Class: casserver
# ===========================
#
#
class casserver {

 class { 'cas': 
   server_name => 'https://cas.upr.edu.cu'
 }
}
