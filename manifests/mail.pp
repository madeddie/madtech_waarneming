# Install and configure mailserver
class role_waarneming::mail (
) {
  # Install postfix
  # listen only on local interfaces
  # set domain as origin
  class { '::postfix':
    inet_interfaces => '127.0.0.1, [::1]',
    myorigin        => 'waarneming.nl',
  }
}
