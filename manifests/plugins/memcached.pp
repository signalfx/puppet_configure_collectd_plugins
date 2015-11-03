# memcached plugin
#
class configure_collectd_plugins::plugins::memcached (
  $hostname  = '127.0.0.1',
  $port      = '11211'
) {
  configure_collectd_plugins::native_plugin { 'memcached':
    plugin_file_name     => '10-memcached.conf',
    plugin_template_name => 'memcached.conf.erb'
  }
}
