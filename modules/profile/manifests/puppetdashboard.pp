class profile::puppetdashboard{
  include roles::mysql
  include roles::passenger
  include roles::dashboard
}

