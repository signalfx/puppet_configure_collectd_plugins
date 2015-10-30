# postgresql plugin
#
class configure_collectd_plugins::plugins::postgresql (
  $hostname,
  $user,
  $password
) {
  configure_collectd_plugins::native_plugin { 'postgresql':
    package_name         => 'collectd-postgresql',
    plugin_file_name     => '10-postgresql.conf',
    plugin_template_name => 'postgresql.conf.erb'
  }
}
