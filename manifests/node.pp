node 'default'{
  include roles::file
}
node 'client-puppet.upr.edu.cu'{
  #include roles::file
  include profile::emai

}
