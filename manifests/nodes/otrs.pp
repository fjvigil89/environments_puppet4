# OTRS hosts
node /^otrs\d+\.ugent\.be$/ {
  include ::otrs_server
}
