node 'nodo6.upr.edu.cu'{
  class { '::basesys':
  uprinfo_usage => 'servidor nodo6',
  application   => 'Nodo 6',
  repos_enabled =>  false,
  }



}

