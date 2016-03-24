# Topbeat class
class beats::topbeat (
  $ensure           = present,
  $period           = 10,
  $procs            = ['.*'],
  $stats_system     = true,
  $stats_proc       = true,
  $stats_filesystem = true,
){
  case $::osfamily {
    'Debian': {
      include ::apt::update
      include beats::topbeat::config
      package {'topbeat':
        ensure  => $ensure,
        require => Class['apt::update']
      }
    }
    'RedHat': {
      include beats::topbeat::config
      package {'topbeat':
        ensure  => $ensure
      }
    }
    default: {
      fail("${::osfamily} not supported yet")
    }
  }

  service { 'topbeat':
    ensure => running,
    enable => true,
  }

  Package['topbeat'] -> Class['beats::topbeat::config'] ~> Service['topbeat']
}