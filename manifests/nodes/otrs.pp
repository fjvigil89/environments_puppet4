# OTRS hosts
node 'otrs.upr.edu.cu' {
  #include ::otrs_server
  realize(User['otrs'])~>
  include ::otrs
}
