class vsftpd {
  package { 'vsftpd':
    ensure => installed
  }

  file {
    '/etc/vsftpd.conf':
      ensure  => present,
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      source  => '/vagrant/puppet/files/vsftpd.conf',
      require => Package['vsftpd']
  }

  service { 'vsftpd':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => File['/etc/vsftpd.conf']
  }
}
