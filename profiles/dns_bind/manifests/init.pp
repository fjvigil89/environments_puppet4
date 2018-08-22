# Class: dns_bind
# ===========================
# 
# Full description of class dns_bind here.
#
class dns_bind (
  Array[String] $zone_name       = $::dns_bind::params::zone_name,
  Array[String] $zone_reverse    = $::dns_bind::params::zone_reverse,
  String $zone_type              = $::dns_bind::params::zone_type,
  String $recursion              = $::dns_bind::params::recursion,
  String $notify                 = $::dns_bind::params::notify,
  Array[String] $mymasters       = $::dns_bind::params::mymasters,
  Array[String] $mymatch_clients = $::dns_bind::params::mymatch_clients,
) inherits ::dns_bind::params {
  #bind::server::conf {
  #  zones => {
  #    each($zone_name) |$value| {
  #      $value = [
  #      $zone_type,
  #      "file db.$value",
  #      ],
  #    },
  #  },

  #views => {
    #  'trusted' => {
    #    'match-clients' => $mymatch_clients,
    #  'zones'         => {
      #    each($zone_name) |$value| {
      #    $value = [
      #      $zone_type,
      #      "file db.$zone_name",
      #    ],
      #  }
      #},
      # each($zone_reverse) |$value| {
      #  $value  = [
      #    $zone_type,
      #    "file db.$value",
      #  ],
      #}
      #},
      #'default' => {
      #'match-clients' => [ 'any' ],
      #},
      # },
      #}
      }
