# OpenVPN module main class. It only takes care of installing openvpn and
# enabling the service.
#
# Sample Usage :
#     include openvpn
#
class openvpn inherits ::openvpn::params {

  package { $openvpn::params::package:
    alias => 'openvpn',
    ensure => installed
  }

  # OpenVPN service, special case since it's one service for all connections
  service { $openvpn::params::service:
    enable  => true,
    require => Package['openvpn'],
  }

}

