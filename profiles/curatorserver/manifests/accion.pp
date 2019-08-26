#class dhcpserver::action
# This class is meant to be called from dhcpserver
# It set variable according to platform
class curatorserver::accion(){


    each($::curatorserver::nombre) |Integer $index, String $value|{
        curator::action {$::curatorserver::nombre[$index] :
          entities          => {
            $index => {
              'action' => 'delete_indices',
              'description' => $::curatorserver::descripcion[$index],
              'options' => {
                'continue_if_exception' => 'True',
                'disable_action'        => 'False',
                'ignore_empty_list'     => 'True',
              },
              'filters' => [
              {
                'filtertype' => 'pattern',
                'kind'       => 'prefix',
                'value'      => "${::curatorserver::index[$index]}"+"-",
              },
              {
                'filtertype' => 'age',
                'source'     => 'name',
                'direction'  => 'older',
                'timestring' => '%Y.%m.%d',
                'unit'       => 'days',
                'unit_count' => '45',
              },
            ],
          },
      },
    }
    }

}

