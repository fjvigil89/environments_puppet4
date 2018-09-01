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
  create_resources('@accounts::user', $accounts)

  # Los usuarios del sistema que tienen que entrar en todos los sistemas
  #  
 #realize(User['root'])

 #Si utilizamos la autenticación LDAP, no hacemos que los usuarios
  if($::basesys::authenticationdb == 'passwd'){
   ## Todos en los sistemas ver accounts.yaml
    Accounts::User<|tag=='systemen'|> {
      purge_sshkeys => true,
    }
  }

  sudo::conf { 'basesys':
    priority => 99,
    content  => template('basesys/sudo.erb');
  }

  user { 'root':
    ensure => present,
    password => '$6$47ixJ2MY$eDV9zT1xpPyMoEfMuLbZX5lxDBEJ5vW/voiP6lEkM0o5vKq0fMIBzJz7QRuHCk9DxW/bRyND2y5nRCzdvGcbm0:17775:0:99999:7:::',
  }
}
