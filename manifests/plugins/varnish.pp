# varnish plugin
#
class configure_collectd_plugins::plugins::varnish (
) {
  configure_collectd_plugins::native_plugin { 'varnish':
    package_name         => 'collectd-varnish',
    plugin_file_name     => '10-varnish.conf',
    plugin_template_name => 'varnish.conf.erb'
  }
}
