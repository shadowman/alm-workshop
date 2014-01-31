#
# All nodes must update apt sources at least once a day.
#
exec { 'apt-get update':
  path    => '/usr/bin:/bin',
  command => 'sudo apt-get update',
  onlyif  => 'find /var/lib/apt/lists -type d -mtime +1 | grep -q /list'
}

#
# Make sure apt is up to date before installing any package.
#
Package {
  require => Exec['apt-get update'],
}

#
# Common setup for all nodes.
#
class common {
  include git

  file { '/etc/hosts':
    ensure => present,
    source => '/vagrant/puppet/files/hosts',
    mode   => '0664',
    owner  => root,
    group  => root
  }
}
