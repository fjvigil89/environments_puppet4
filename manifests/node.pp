node 'default'{
  include profile::file
}
node 'client-puppet.upr.edu.cu'{
  include profile::file
  include profile::puppetdashboard
  #include profile::email

}
