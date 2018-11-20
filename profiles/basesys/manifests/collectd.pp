#class: basesys::collectd
# ===========================
#
#
class basesys::collectd {
  class { '::collectd':
  purge           => true,
  recurse         => true,
  purge_config    => true,
}
collectd::plugin::write_graphite::carbon { 'graphite':
      graphitehost      => $basesys::params::graphite_host,
      graphiteport      => 2003,
      graphiteprefix    => 'collectd.',
      protocol          => 'tcp',
      escapecharacter   => '_',
      alwaysappendds    => false,
      storerates        => false,
      separateinstances => false,
      logsenderrors     => true,
    }
    include  ::collectd::plugin::syslog
    include  ::collectd::plugin::cpu
    include  ::collectd::plugin::df
    include  ::collectd::plugin::disk
    include  ::collectd::plugin::interface
    include  ::collectd::plugin::load
    include  ::collectd::plugin::memory
    include  ::collectd::plugin::network
    include  ::collectd::plugin::processes
    include  ::collectd::plugin::swap
    include  ::collectd::plugin::users
}
