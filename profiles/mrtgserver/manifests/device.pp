# Class: mrtgserver::device
#
class mrtgserver::device {
  each ($::mrtgserver::ip) |Integer $index, String $value|{
    exec {'cfgmaker':
      command => "cfgmaker $community@$value > /etc/mrtg/$names[$index].cfg"
      }
  }
}
