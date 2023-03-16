# OpenVPN module main class. It only takes care of installing openvpn and
# enabling the service.
#
# Sample Usage :
#     include openvpn
#
class openvpn inherits ::openvpn::params {

  package { $openvpn::params::package:
    ensure => 'installed',
    alias  => 'openvpn',
  }

  # OpenVPN service, special case since it's one service for all connections
  if $::openvpn::params::multiservice == false {
    service { $openvpn::params::service:
      enable  => true,
      require => Package[$::openvpn::params::package],
    }
  }

}

