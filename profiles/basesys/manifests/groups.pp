# Beheer van groupen
class basesys::groups (
) {
  # Systeem user uit hiera, zie basesys/data/groups.yml
  $groups = lookup('basesys::system_groups', {merge => hash, default_value => {}})
  create_resources('@groups', $groups)


}
