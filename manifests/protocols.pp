# Define::beats::protocols 
# Sets up protocols. I think it's redundant...?
define beats::protocols($protocol,$ports)
{
  concat::fragment {"protocols-${protocol}":
    target  => '/etc/beats/beats.conf',
    content => template('beats/protocols.conf.erb'),
    order   => 20,
  }
}
