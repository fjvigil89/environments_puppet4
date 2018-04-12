class roles::git{
include git
class{git:
  svn => true,
  gui => true,
}
}
