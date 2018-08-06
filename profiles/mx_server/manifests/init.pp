# Class: mx_server
# ===========================
# Configure MX Server
#
class mx_server {
  include razor::server
  include mx_server::postfix
  include mx_server::spamassassin
  include mx_server::install
}
