# The secret file must be manually generated and stored on the puppetmaster.
# To generate an OpenVPN secret file :
#     openvpn --genkey --secret example.key
# Usage :
#     openvpn::secret { 'example.key':
#       source => 'puppet:///files/openvpn/example.key',
#     }
#
define openvpn::secret (
  $ensure  = undef,
  $dir     = undef,
  $source  = undef,
  $content = undef
) {

  include '::openvpn'

  $config_dir = pick($dir, $::openvpn::params::dir)

  file { "${config_dir}/${title}":
    ensure    => $ensure,
    owner     => 'root',
    group     => 'root',
    mode      => '0600',
    source    => $source,
    content   => $content,
    # Don't output change details to logs
    show_diff => false,
    # For the default parent directory
    require   => Package[$::openvpn::params::package],
  }

}

