# Beheer van groupen
class basesys::groups (
) {
  # Systeem user uit hiera, zie basesys/data/groups.yml
  $system_groups = lookup('basesys::system_groups', {merge => hash, default_value => {}})
  create_resources('@group', $system_groups)

  ## Todos en los sistemas ver accounts.yaml
   Group::System_groups<|ensure=='present'|> {
     #purge_sshkeys => true,
   }

}
