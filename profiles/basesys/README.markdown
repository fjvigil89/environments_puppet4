# basesys

[![Build Status](https://travis-ci.org/root/puppet-basesys.png?branch=master)](https://travis-ci.org/root/puppet-basesys)

This is the basesys module.

# Requirements

# Installation

  puppet module install root/basesys

# Synopsis
Se agrego un parámetro el modulo basesys de puppet, demominado dmz, que por defecto es false, se activa cuando sea un servidor con ip publico, al poner el parámetro en true, pues escribe en el resolv.conf 200.14.49.2 como dns autoritario para resolver nuestro dominio, si deseamos que cualquiera de los registros dns que tiene ns1 responda por un ip privado, se modifica la zona interna, pq la externa es para atender las peticiones desde internet.
# Parameters

- *enable*

# License

  See LICENSE

# Contact


# Support

Please log tickets and issues at our [Projects site](http://gitlab.upr.edu.cu/dcenter/environments/tree/production/profiles/basesys)
