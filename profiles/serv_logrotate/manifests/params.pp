# Class: serv_logrotate::params
# ===========================
#
# Full description of class serv_logrotate::params here.
#
class serv_logrotate::params {
    $compress         = true
    # rotate params like 5
    $filelog_numbers  = []

    #Action to be done 
    $postrotate       = []
    $prerotate        = []

    #rotate_every
    $rotate_frecuency = ['week']
    
    # list of logs name
    $rule_list        = []
    
    # list of paths log
    $log_path         = []
}
