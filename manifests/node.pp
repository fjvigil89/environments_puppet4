node 'default'{
  include roles::file
}
node 'client-puppet.upr.edu.cu'{
  include profile::file
  include profile::puppetdashboard
  #include profile::email

}
