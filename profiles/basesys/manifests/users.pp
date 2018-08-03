# Class: basesys::users
# ===========================
#
# Users configuratie.
# We hebben twee soorten 'users', en beide zijn virtual resources.
# 1) @user
# 2) @accounts::user'
#
# Zie https://wiki.ugent.be/display/SYSADMIN/Basesys+profiel#Basesysprofiel-Accountsaanmaken
class basesys::users (
  ){

  # Systeem users komt uit Hiera. zie data/common.yaml
  $system_users = lookup('basesys::system_users', {merge => hash, default_value => {}})
  create_resources('@user', $system_users)

  # accounts::user komt uit Hiera. zie data/common.yaml
  $accounts = lookup('basesys::accounts', {merge => hash, default_value => {}})
  #create_resources('@accounts', $accounts)

  # Systeem users die op alle systemen moeten komen
  realize(User['puppet_admin'])

  # Als we LDAP authenticatie gebruiken maken we de users niet
  if($::basesys::authenticationdb == 'passwd'){
    # Iedereen in systemen zie accounts.yaml
    Accounts::User<|tag=='systemen'|> {
      purge_sshkeys => true,
    }
  }

  sudo::conf { 'basesys':
    priority => 99,
    content  => template('basesys/sudo.erb');
  }
}
