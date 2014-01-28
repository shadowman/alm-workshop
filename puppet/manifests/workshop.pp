exec { 'apt-get update':
	path => "/usr/bin:/bin",
	command => 'sudo apt-get update',
	onlyif  => 'find /var/lib/apt/lists -type d -mtime +1 | grep -q /list'
}

Package {
	require => Exec['apt-get update'],
}

class git {
	package { "git":
		ensure => installed
	}
}

class common {
	include git
	file { "/etc/hosts":
		ensure => present,
		source => "/vagrant/puppet/files/hosts",
		mode => 664,
		owner => root,
		group => root

	}
}

node "ci" {
	include common
	package { "jenkins":
		ensure => installed
	}
}

node "dev" {
	include common
}




