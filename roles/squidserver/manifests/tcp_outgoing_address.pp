define squidserver::tcp_outgoing_address(
  Array[String] $value   = ['0.0.0.0'],
  Array[String] $acl_name= [''],
  String  $comment       = "Lista de redes para distribuir ${title}",
  String $order          = '05',
) {
  squid::tcp_outgoing_address {$title:
    value    => $value,
    acl_name => $acl_name,
    comment  => $comment,
    order    => $order,
  }

}
