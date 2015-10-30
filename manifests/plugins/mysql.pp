# mysql plugin
#
class configure_collectd_plugins::plugins::mysql (
  $hostname,
  $user,
  $password,
  $database
) {

  if $::osfamily == 'Debian' {
    $socket = '/var/lib/mysqld/mysqld.sock'
  }
  elsif $::osfamily == 'Redhat' {
    $socket = '/var/lib/mysql/mysql.sock'
  }

  configure_collectd_plugins::native_plugin { 'mysql':
    package_name         => 'collectd-mysql',
    plugin_file_name     => '10-mysql.conf',
    plugin_template_name => 'mysql.conf.erb'
  }
}
