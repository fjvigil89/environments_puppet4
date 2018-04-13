class roles::mysql(
$name_db,
$name_user,
$pass_db
) {
  $override_options = {
  'section' =>  {
  'item' =>  'thing',
  }
  }
  mysql::db{ $name_db:
  user => $name_user,
  password => $pass_db,
  host => 'localhost',
  grant => ['SELECT', 'UPDATE'],
  }
  class { '::mysql::server':
  root_password =>  '123',
  remove_default_accounts =>  true,
  override_options =>  $override_options
  }
}
