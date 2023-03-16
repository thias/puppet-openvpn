# Class: openvpn::params
#
class openvpn::params {

  case $::operatingsystem {
    'RedHat', 'Fedora', 'CentOS': {
      $package = 'openvpn'
      if versioncmp($::operatingsystemrelease, '7') >= 0 {
        $multiservice = 'systemd'
      } else {
        $multiservice = false
      }
      if versioncmp($::operatingsystemrelease, '9') >= 0 {
        $service = 'openvpn-server'
        $dir = '/etc/openvpn/server'
      } else {
        $service = 'openvpn'
        $dir = '/etc/openvpn'
      }
    }
    'Gentoo': {
      $package = 'net-misc/openvpn'
      $service = 'openvpn'
      $multiservice = 'init'
      $dir = '/etc/openvpn'
    }
    'Ubuntu', 'Debian': {
      $package = 'openvpn'
      $service = 'openvpn'
      if versioncmp($::operatingsystemrelease, '16') >= 0 {
        $multiservice = 'systemd'
      } else {
        $multiservice = false
      }
      $dir = '/etc/openvpn'
    }
    default: {
      # Bail out, since work will be needed
      fail("Unsupported operatingsystem ${::operatingsystem}.")
    }
  }

}

