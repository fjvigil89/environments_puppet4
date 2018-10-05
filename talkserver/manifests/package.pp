#Clase package
class talkserver::package {
  package { 'prosody' :
    ensure  => present,
  }
}
