# OpenVPN configuration from source or template.
# FIXME : Implement auto restart of the configured link after changes.
#
define openvpn::conf (
  $ensure  = undef,
  $service = undef,
  $dir     = undef,
  $source  = undef,
  $content = undef,
) {

  if $ensure == 'absent' {
    $ensure_service = 'stopped'
    $ensure_link = 'absent'
  } else {
    $ensure_service = 'running'
    $ensure_link = 'link'
  }

  include '::openvpn'

  $config_dir = pick($dir, $::openvpn::params::dir)
  $service_name = pick($service, $::openvpn::params::service)

  file { "${config_dir}/${title}.conf":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    source  => $source,
    content => $content,
    # For the default parent directory
    require => Package[$::openvpn::params::package],
  }

  if $::openvpn::params::multiservice == 'init' {

    file { "/etc/init.d/openvpn.${title}":
      ensure  => $ensure_link,
      owner   => 'root',
      group   => 'root',
      target  => 'openvpn',
      require => Package[$::openvpn::params::package],
    }
    service { "openvpn.${title}":
      ensure    => $ensure_service,
      enable    => true,
      require   => File["/etc/init.d/openvpn.${title}"],
      subscribe => File["${config_dir}/${title}.conf"],
    }

  } elsif $::openvpn::params::multiservice == 'systemd' {

    service { "${service_name}@${title}":
      ensure    => $ensure_service,
      # This doesn't work (RHEL7 RC, 201404), work around below (still not 7.1)
      #enable  => true,
      subscribe => File["${config_dir}/${title}.conf"],
    }
    if $ensure == 'absent' {
      exec { "systemctl disable ${service_name}@${title}.service":
        onlyif => "test -f /etc/systemd/system/multi-user.target.wants/${service_name}@${title}.service",
        path   => [ '/bin', '/usr/bin' ],
      }
    } else {
      # FIXME : 'sytemctl enable' broke from RHEL 7.0 to 7.1 with
      #         'Failed to issue method call: No such file or directory'
      #exec { "systemctl enable ${service_name}@${title}.service":
      #  creates => "/etc/systemd/system/multi-user.target.wants/${service_name}@${title}.service",
      #  path    => [ '/bin', '/usr/bin' ],
      #}
      file { "/etc/systemd/system/multi-user.target.wants/${service_name}@${title}.service":
        ensure => 'link',
        target => "/usr/lib/systemd/system/${service_name}@.service",
      }
    }

  } else {

    # FIXME : Support stop for ensure => absent
    # start
    exec { "openvpn-start-${title}":
      command => "/usr/sbin/openvpn --daemon --writepid /var/run/openvpn/${title}.pid --config ${title}.conf --cd ${config_dir}",
      cwd     => $dir,
      require => File["${config_dir}/${title}.conf"],
      creates => "/var/run/openvpn/${title}.pid",
    }
    # FIXME : stop/restart
    exec { "openvpn-stop-${title}":
      command     => "kill `cat /var/run/openvpn/${title}.pid`",
      path        => [ '/bin', '/usr/bin' ],
      refreshonly => true,
    }

  }

}
