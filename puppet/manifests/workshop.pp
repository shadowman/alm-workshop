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

node "ci" {
	include git	
	package { "jenkins":
		ensure => installed
	}
}

node "dev" {
	include git
}



