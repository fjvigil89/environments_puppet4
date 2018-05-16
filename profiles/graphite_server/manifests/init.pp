#
#  Class graphite_server
#================================
#

class graphite_server {
class { 'graphite': 
gr_pip_install        => false,
    gr_django_tagging_pkg => 'python-django-tagging',
    gr_django_tagging_ver => 'present',
    gr_twisted_pkg        => 'python-twisted',
    gr_twisted_ver        => 'present',
    gr_txamqp_pkg         => 'python-txamqp',
    gr_txamqp_ver         => 'present',
    gr_graphite_pkg       => 'python-graphite-web',
    gr_graphite_ver       => 'present',
    gr_carbon_pkg         => 'python-carbon',
    gr_carbon_ver         => 'present',
    gr_whisper_pkg        => 'python-whisper',
    gr_whisper_ver        => 'present',
}
}

