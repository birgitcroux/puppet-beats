# Filebeat
class beats::filebeat (
  $ensure         = present,
  $service_ensure = running,
  $service_enable = true,
  $idle_timeout   = '5s',
  $prospectors    = {},
  $registry_file  = '/var/lib/filebeat/registry',
  $spool_size     = 1024,
){

  beats::common::headers {'filebeat':}
  concat::fragment {'filebeat.header':
    target  => '/etc/filebeat/filebeat.yml',
    content => template('beats/filebeat/filebeat.yml.erb'),
    order   => 05,
    notify  => Service['filebeat'],
  }

  include ::apt::update

  package {'filebeat':
    ensure  => $ensure,
    require => Class['apt::update']
  }
  service { 'filebeat':
    ensure => $service_ensure,
    enable => $service_enable,
  }
  if $prospectors {
    create_resources('::beats::filebeat::prospector', $prospectors )
  }

  Package['filebeat'] -> Concat::Fragment['filebeat.header'] ->
  Beats::Filebeat::Prospector <||> ~> Service['filebeat']
}