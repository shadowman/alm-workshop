#
# Git server configuration
#
class git::server inherits git {
	
	# Ensure ssh server is present
	package { 'openssh-server':
		ensure => present,
	}

	# Ensure sshd is running
	service { 'ssh':
 		ensure => running,
 		enable => true,
 		hasstatus => true,
 		hasrestart => true,
	}

	# Setup the git user
	user { "git":
		ensure => present,
		shell => "/usr/bin/git-shell",
      	managehome => true
	}

	# Finish seting up the git shell
	file { "/home/git/git-shell-commands":
		ensure  => directory,
		owner	=> "git",
		group	=> "git",
		mode	=> "664"
	}
	
	# Add host keys to the ssh server authorized_keys file for the git user
	file { "/home/git/.ssh":
		ensure  => directory,
		owner   => "git",
		group   => "git"
	}

	file { "/home/git/.ssh/authorized_keys":
		ensure  => file,
		recurse => true,
		owner   => "git",
		group   => "git",
		mode	=> 664,
		source  => "file:////etc/ssh/ssh_host_rsa_key.pub"
	}
}
