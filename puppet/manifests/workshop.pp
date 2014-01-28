class git {
	exec { 'apt-get update':
		command => '/usr/bin/sudo apt-get update';
	}
	package { "git":
		ensure => installed,
		require => Exec['apt-get update'];
	}
}

node "ci" {
	include git	
}

node "dev" {
	include git
}



