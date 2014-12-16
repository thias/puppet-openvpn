# puppet-openvpn

## Overview

Puppet module to manage OpenVPN links. It supports Red Hat Enterprise Linux
(RHEL) or any of its clones, as well as Gentoo Linux, and should be easy to
modify to support more distributions.

* `openvpn` : Main class to install, enable and configure the service.
* `openvpn::conf` : Definition to manage OpenVPN configuration files.
* `openvpn::conftemplate` : Same as conf, but based on an included template.
* `openvpn::secret` : Definition to manage OpenVPN secret key files.
* `openvpn::startup_script` : Class to configure an optional startup script.

## Examples

Basic OpenVPN setup :

```puppet
include '::openvpn'
openvpn::secret { 'example.key':
  source => 'puppet:///modules/mymodule/openvpn/example.key',
}
openvpn::conftemplate { 'example':
  dev              => 'tun0',
  remote           => 'remote-server.example.com',
  ipaddress_local  => '192.168.0.1',
  ipaddress_remote => '192.168.0.2',
  routes           => [ '192.168.1.0 255.255.255.0' ],
  secret           => 'example.key',
}
```

For a user VPN we also need to pre-create a tap device when OpenVPN starts
and add it to an existing network bridge :

```puppet
$tapdev = 'tap1'
$tapbridge = 'br1'
class { '::openvpn::startup_script':
  content => template('openvpn/openvpn-startup.erb'),
}
```

If you intend to run OpenVPN on non-standard ports, you will need to modify
your SELinux policy accordingly. Here is one (fragile) way of doing it :

```puppet
# Add 4100-4149 udp port range for OpenVPN links
exec { '/usr/sbin/semanage port -a -t openvpn_port_t -p udp 4100-4149':
    unless => '/usr/sbin/semanage port -l -C | /bin/grep -q openvpn_port_t',
}
```

