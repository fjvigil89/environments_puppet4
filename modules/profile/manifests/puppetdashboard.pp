class profile::puppetdashboard{
  include roles::apache2
  include roles::mysql
  include roles::passenger
  include roles::dashboard
}

