class profile::puppetdashboard{
  # include roles::apache2
  #include roles::mysql
  #include roles::passenger
  include puppetboardserver::apache
  include roles::dashboard
}

