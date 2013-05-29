# Class: openvpn::params
#
class openvpn::params {

  case $::operatingsystem {
    'RedHat', 'Fedora', 'CentOS': {
      $package = 'openvpn'
      $service = 'openvpn'
      $multiservice = false
    }
    'Gentoo': {
      $package = 'net-misc/openvpn'
      $service = 'openvpn'
      $multiservice = true
    }
    default: {
      # Bail out, since work will be needed
      fail("Unsupported operatingsystem ${::operatingsystem}.")
    }
  }

}

