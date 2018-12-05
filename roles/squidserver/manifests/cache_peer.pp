define squidserver::cache_peer (
  Array[String]  $proxy_port             = [],
  Array[String]  $icp_port               = [],
  Array[String] $options          = [],
  String  $order                  = '05',
  Array[String] $type             = [],
  Array[String]  $pattern         = [],
  String  $comment                = "refresh_pattern fragment for ${title}",
) {
  
  squid::cache_peer{$title :
    pattern    => $pattern,
    type       => $type,
    proxy_port => $proxy_port,
    icp_port   => $icp_port,
    options    => $options,
    order      => $order,
    comment    => $comment,
  }


}
