<<<<<<< HEAD
node default {
    
  notify{'default_node_inclusion':
    message =>  'Este nodo no tiene catalogos',
  }
}

=======

node default {

  notify{'default_node_inclusion':
    message =>  'Upss !!! - El Nodo por defecto no ha sido asignado - Porfavor contacte con su administrador',
  }

}
>>>>>>> f267099546ef27452d83a0c0089a86e8300691f4
