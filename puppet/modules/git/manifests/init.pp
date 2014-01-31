#
# Install git package.
#
class git {
  package { 'git':
    ensure => installed
  }
}
