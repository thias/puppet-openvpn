# Class: openvpn::startup_script
#
# Example Usage:
#  $tapdev = 'tap1'
#  $tapbridge = 'br1'
#  class { 'openvpn::startup_script':
#      content => template('openvpn/openvpn-startup.erb'),
#  }
#
class openvpn::startup_script (
  $dir = undef,
  $source  = undef,
  $content = undef
) {

  include '::openvpn::params'

  $config_dir = pick($dir, $::openvpn::params::dir)

  # Multi-service is tricky, many service names...
  if ! $::openvpn::params::multiservice {
    File["${config_dir}/openvpn-startup"] ~> Service[$::openvpn::params::service]
  }

  file { "${config_dir}/openvpn-startup":
    owner   => 'root',
    group   => 'root',
    mode    => '0750',
    source  => $source,
    content => $content,
    # For the default parent directory
    require => Package[$::openvpn::params::package],
  }

}

