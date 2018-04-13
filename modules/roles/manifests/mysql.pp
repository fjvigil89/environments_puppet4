class roles::mysql {
  $override_options = {
  'section' =>  {
  'item' =>  'thing',
  }
  }
  mysql::db{ 'mydb':
  user => 'myuser',
  password =>  'mypass',
  host => 'localhost',
  grant => ['SELECT', 'UPDATE'],
  }
  class { '::mysql::server':
  root_password =>  '123',
  remove_default_accounts =>  true,
  override_options =>  $override_options
  }
}
