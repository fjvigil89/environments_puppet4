#class dhcpserver::action
# This class is meant to be called from dhcpserver
# It set variable according to platform
class curatorserver::job(){

  each($::curatorserver::nombre) |Integer $index, String $value|{
     curator::job { "${value}_everyday":
        action => "${value}",
        minute => 0,
        hour   => 2,
      }

  }
}

