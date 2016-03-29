# Install and configure PgBouncer
class role_waarneming::pgbouncer (
  $waarneming_pw = postgresql_password('waarneming', $::role_waarneming::conf::waarneming_password),
  $local_be_pw   = postgresql_password('local_be', $::role_waarneming::conf::local_be_password),
  $local_nl_pw   = postgresql_password('local_nl', $::role_waarneming::conf::local_nl_password),
  $local_xx_pw   = postgresql_password('local_xx', $::role_waarneming::conf::local_xx_password),
) {
  # Install PostgreSQL client software
  class { '::postgresql::client':
    require => Class['postgresql::globals'],
  }->
  class { '::pgbouncer':
    listen_port => $::role_waarneming::conf::pgbouncer_port,
    databases   => [ "* = host=${$::role_waarneming::conf::db_host}", ],
    admin_users => 'hugo,hugoadmin,dylan,dylanadmin,hisko,hiskoadmin',
    auth_type   => 'md5',
    auth_list   => [
      "\"waarneming\" \"${waarneming_pw}\"",
      "\"local_be\" \"${local_be_pw}\"",
      "\"local_nl\" \"${local_nl_pw}\"",
      "\"local_xx\" \"${local_xx_pw}\"",
    ],
    pool_mode   => 'session',
    pidfile     => '/var/run/postgresql/pgbouncer.pid',
  }
}
