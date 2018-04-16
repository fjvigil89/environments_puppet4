class roles::passenger{
  class {'passenger':
    #passenger_version =>  '2.2.11',
    #passenger_provider =>  'gem',
    #passenger_package =>  'passenger',
    #gem_path =>  '/var/lib/gems/1.8/gems',
    #gem_binary_path =>  '/var/lib/gems/1.8/bin',
    #passenger_root =>  '/var/lib/gems/1.8/gems/passenger-2.2.11'
    #mod_passenger_location =>  '/var/lib/gems/1.8/gems/passenger-2.2.11/ext/apache2/mod_passenger.so',
    #include_build_tools =>  true,
 }
}
