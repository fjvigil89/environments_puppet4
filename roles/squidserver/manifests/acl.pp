define squidserver::acl (
  String $type,
  String $aclname = $title,
  Array  $entries = [],
  String $order   = '05',
  String $comment = "acl fragment for ${aclname}",
) {
  squid::acl { $title :
    type    => $type,
    aclname => $title,
    entries => $entries,
    order   => $order,
    comment => $comment,

  }
  
}
