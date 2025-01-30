# Class: openvpn::params
#
class openvpn::params {

  case $facts['os']['name'] {
    'RedHat', 'Fedora', 'CentOS': {
      $package = 'openvpn'
      if versioncmp($facts['os']['release']['major'], '7') >= 0 {
        $multiservice = 'systemd'
      } else {
        $multiservice = false
      }
      if versioncmp($facts['os']['release']['major'], '9') >= 0 {
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
      if versioncmp($facts['os']['release']['major'], '16') >= 0 {
        $multiservice = 'systemd'
      } else {
        $multiservice = false
      }
      $dir = '/etc/openvpn'
    }
    default: {
      # Bail out, since work will be needed
      fail("Unsupported operatingsystem ${facts['os']['name']}.")
    }
  }

}

