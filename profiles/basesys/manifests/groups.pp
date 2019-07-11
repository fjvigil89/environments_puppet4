# Beheer van groupen
class basesys::groups (
) {
  # Systeem user uit hiera, zie basesys/data/groups.yml
  $system_groups = lookup('basesys::system_groups', {merge => hash, default_value => {}})
  create_resources('@groups', $group)

  ## Todos en los sistemas ver accounts.yaml
   Groups::Group<|ensure=='present'|> {
     #purge_sshkeys => true,
   }

}
