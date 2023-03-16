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
  $cipher           = undef,
  $ipaddress_local  = $::ipaddress,
  $routes           = [],
  $port             = '1194',
  $comp_lzo         = true,
  $user             = 'openvpn',
  $group            = 'openvpn',
  $verb             = '3',
  $extra_lines      = [],
  # Main options
  $dir              = undef,
) {

  include '::openvpn::params'

  $config_dir = pick($dir, $::openvpn::params::dir)

  openvpn::conf { $title:
    dir     => $config_dir,
    content => template('openvpn/default.conf.erb'),
    # The secret file referenced, which already requires the parent dir
    require => File["${config_dir}/${secret}"],
  }

}

