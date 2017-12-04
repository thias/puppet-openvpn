# Define: openvpn::conftemplate
#
# Wrapper around openvpn::conf which uses a template included in the module,
# useful for simple shared key VPN links.
#
define openvpn::conftemplate (
  # Template options
  $dev,
  $remote,
  $ipaddress_remote,
  $secret,
  $local            = undef,
  $proto            = undef,
  $fragment         = undef,
  $mssfix           = undef,
  $float            = undef,
  $ipaddress_local  = $::ipaddress,
  $routes           = [],
  $port             = '1194',
  $user             = 'openvpn',
  $group            = 'openvpn',
  $verb             = '3',
  # Main options
  $dir              = '/etc/openvpn',
) {

  openvpn::conf { $title:
    dir     => $dir,
    content => template('openvpn/default.conf.erb'),
    # The secret file referenced, which already requires the parent dir
    require => File["${dir}/${secret}"],
  }

}

