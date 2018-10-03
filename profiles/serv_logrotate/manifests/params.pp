# Class: serv_logrotate::params
# ===========================
#
# Full description of class serv_logrotate::params here.
#
class serv_logrotate::params {
    $compress         = true
    
    # rotate params like 5
    $filelog_numbers  = [] 
    
    #rotate_every
    $rotate_frecuency = ['week']

    $rule_list        = []
    $log_path         = []
}
