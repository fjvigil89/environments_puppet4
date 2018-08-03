# Class: basesys::users
# ===========================
#
# Configuración de usuarios.
# Tenemos dos tipos de 'usuarios', y ambos son recursos virtuales.
# 1) @user
# 2) @accounts::user'
#
# Zie https://wiki.ugent.be/display/SYSADMIN/Basesys+profiel#Basesysprofiel-Accountsaanmaken
class basesys::users (
  ){

  # Systeem users viene de Hiera. ver data/common.yaml
  $system_users = lookup('basesys::system_users', {merge => hash, default_value => {}})
  create_resources('@user', $system_users)

  # accounts::user viene de Hiera. ver data/common.yaml
  $accounts = lookup('basesys::accounts', {merge => hash, default_value => {}})
  create_resources('@accounts', $accounts)

  # Los usuarios del sistema que tienen que entrar en todos los sistemas
  realize(User['ansible'])

  # Si utilizamos la autenticación LDAP, no hacemos que los usuarios
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
