# Beheer van groupen
class basesys::groups (
) {
  # Systeem user uit hiera, zie basesys/data/groups.yml
  $system_groups = lookup('basesys::system_groups', {merge => hash, default_value => {}})
  create_resources('@system_groups', $group)

  ## Todos en los sistemas ver accounts.yaml
   System_groups::Group<|ensure=='present'|> {
     #purge_sshkeys => true,
   }

}
