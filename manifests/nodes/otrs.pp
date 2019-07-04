# OTRS hosts
node /^otrs\d+\.upr\.edu\.cu$/ {
  include ::otrs_server
}
