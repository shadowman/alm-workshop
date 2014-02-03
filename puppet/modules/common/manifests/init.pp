#
# All nodes must update apt sources at least once a day.
#
exec { 'apt-get update':
  path    => '/usr/bin:/bin',
  command => 'sudo apt-get update',
  onlyif  => 'find /var/lib/apt/lists -type d -mtime +1 | grep -q /lists'
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

  # Update hosts file so that VM can call eachother 
  # without ip's being referenced explicitly
  file { '/etc/hosts':
    ensure => present,
    source => '/vagrant/puppet/files/hosts',
    mode   => '0644',
    owner  => root,
    group  => root
  }

  # Have the vagrant user use the host key as his id
  file { "/home/vagrant/.ssh/id_rsa":
    ensure  => file,
    recurse => true,
    owner   => "vagrant",
    group   => "vagrant",
    mode  => 600,
    source  => "file:////etc/ssh/ssh_host_rsa_key"
  }

  # Read pubkey contents and parse its fields into an array.
  $pubkey_contents = file('/etc/ssh/ssh_host_rsa_key.pub')
  $pubkey_fields   = split($pubkey_contents, ' ')
  $pubkey_target   = '/etc/ssh/ssh_known_hosts'

  # Make sure the target file has the proper mode and ownership.
  file { $pubkey_target:
    ensure => present,
    mode   => '0644',
    owner  => root,
    group  => root
  }

  # Define a common sshkey for all nodes from a pubkey file.
  sshkey { 'common pubkey':
    ensure       => present,
    target       => $pubkey_target,
    require      => File[$pubkey_target],
    type         => $pubkey_fields[0],
    key          => $pubkey_fields[1],
    name         => 'precise32',
    host_aliases => [
      'dev', '10.10.10.2',
      'ci',  '10.10.10.3',
      'cvs', '10.10.10.4',
    ]
  }
}
