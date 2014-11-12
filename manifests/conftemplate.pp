# Define: openvpn::conftemplate
#
# Wrapper around openvpn::conf which uses a template included in the module,
# useful for simple shared key VPN links.
#
define openvpn::conftemplate (
  $dir              = '/etc/openvpn',
  # Template options
  $dev,
  $fragment         = undef,
  $mssfix           = undef,
  $remote,
  $float            = undef,
  $ipaddress_local  = $::ipaddress,
  $ipaddress_remote,
  $routes           = [],
  $secret,
  $port             = '1194',
  $user             = 'openvpn',
  $group            = 'openvpn',
  $verb             = '3'
) {

  openvpn::conf { $title:
    dir     => $dir,
    content => template('openvpn/default.conf.erb'),
    # The secret file referenced, which already requires the parent dir
    require => File["${dir}/${secret}"],
  }

}

