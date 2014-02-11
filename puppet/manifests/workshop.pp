node 'ci' {
  include common
  package { 'jenkins':
    ensure => installed
  }
}

node 'dev' {
  include common
}

node 'cvs' {
  include common
  include git::server
}

node 'pre' {
  include common
  include vsftpd
  package { 'apache2':
    ensure => installed
  }
}
