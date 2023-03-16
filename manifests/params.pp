# Class: openvpn::params
#
class openvpn::params {

  case $::operatingsystem {
    'RedHat', 'Fedora', 'CentOS': {
      $package = 'openvpn'
      $service = 'openvpn'
      if versioncmp($::operatingsystemrelease, '7') >= 0 {
        $multiservice = 'systemd'
      } else {
        $multiservice = false
      }
    }
    'Gentoo': {
      $package = 'net-misc/openvpn'
      $service = 'openvpn'
      $multiservice = 'init'
    }
    'Ubuntu', 'Debian': {
      $package = 'openvpn'
      $service = 'openvpn'
      if versioncmp($::operatingsystemrelease, '16') >= 0 {
        $multiservice = 'systemd'
      } else {
        $multiservice = false
      }
    }
    default: {
      # Bail out, since work will be needed
      fail("Unsupported operatingsystem ${::operatingsystem}.")
    }
  }

}

