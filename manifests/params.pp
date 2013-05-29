# Class: openvpn::params
#
class openvpn::params {

  case $::operatingsystem {
    'RedHat', 'Fedora', 'CentOS': {
      $package = 'openvpn'
      $service = 'openvpn'
    }
    'Gentoo': {
      $package = 'net-misc/openvpn'
      $service = 'openvpn'
    }
    default: {
      # Bail out, since work will be needed
      fail("Unsupported operatingsystem ${::operatingsystem}.")
    }
  }

}

