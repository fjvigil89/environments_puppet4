# haproxy_serv

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with haproxy_serv](#setup)
    * [What haproxy_serv affects](#what-haproxy_serv-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with haproxy_serv](#beginning-with-haproxy_serv)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Start with a one- or two-sentence summary of what the module does and/or what
problem it solves. This is your 30-second elevator pitch for your module.
Consider including OS/Puppet version it works with.

You can give more descriptive information in a second paragraph. This paragraph
should answer the questions: "What does this module *do*?" and "Why would I use
it?" If your module has a range of functionality (installation, configuration,
management, etc.), this is the time to mention it.

## Setup

### What haproxy_serv affects **OPTIONAL**

If it's obvious what your module touches, you can skip this section. For
example, folks can probably figure out that your mysql_instance module affects
their MySQL instances.

If there's more that they should know about, though, this is the place to mention:

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute.
* Dependencies that your module automatically installs.
* Warnings or other important notices.

### Setup Requirements **OPTIONAL**

If your module requires anything extra before setting up (pluginsync enabled,
etc.), mention it here.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you might want to include an additional "Upgrading" section
here.

### Beginning with haproxy_serv

The very basic steps needed for a user to get the module up and running. This
can include setup steps, if necessary, or it can be an example of the most
basic use of the module.

## Usage

This section is where you describe how to customize, configure, and do the
fancy stuff with your module here. It's especially helpful if you include usage
examples and code samples for doing things with your module.
36   class {'::haproxy_serv':
 35   ¦ enable_ssl        => true,
 34   ¦ ipaddress         => $ipaddress,
 33   ¦ listening_service => 'nginx00',
 32   ¦ mode              => 'http',
 31   ¦ balancer_member   => ['nginx00', 'nginx01'],
 30   ¦ server_names      => ['nginx00.upr.edu.cu', 'nginx01.upr.edu.cu'],
 29   ¦ ipaddresses       => ['10.2.1.77','10.2.1.79'],
 28   ¦ ports             => ['80','443'],
 27   ¦ frontend_name     => 'nginx_server',
 26   ¦ frontend_options  => {
 25   ¦ ¦ 'default_backend' => 'nginx_backend' ,
 24   ¦ ¦ 'timeout client'  => '30s' ,
 23   ¦ ¦ 'option'          => [
 22   ¦ ¦ ¦ 'tcplog',
 21   ¦ ¦ ],
 20   ¦ ¦ },
 19   ¦ backend_names     => ['nginx_backend'],
 18   ¦ backend_options   => {
 17   ¦ ¦ 'option'  => [
 16   ¦ ¦ ¦ 'tcplog',
 15   ¦ ¦ ],
 14   ¦ ¦ 'balance' => 'roundrobin',
 13   ¦ },
 12   ¦ bind              => {
 11   ¦ ¦ '0.0.0.0:80'  => [],
 10   ¦ ¦ '0.0.0.0:443' => [],
  9   ¦ },
  8   }


## Reference

Users need a complete list of your module's classes, types, defined types providers, facts, and functions, along with the parameters for each. You can provide this list either via Puppet Strings code comments or as a complete list in this Reference section.

* If you are using Puppet Strings code comments, this Reference section should include Strings information so that your users know how to access your documentation.

* If you are not using Puppet Strings, include a list of all of your classes, defined types, and so on, along with their parameters. Each element in this listing should include:

  * The data type, if applicable.
  * A description of what the element does.
  * Valid values, if the data type doesn't make it obvious.
  * Default value, if any.

## Limitations

This is where you list OS compatibility, version compatibility, etc. If there
are Known Issues, you might want to include them under their own heading here.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You can also add any additional sections you feel
are necessary or important to include here. Please use the `## ` header.
