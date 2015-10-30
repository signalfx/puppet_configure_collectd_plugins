# apache plugin
#
class configure_collectd_plugins::plugins::apache (
  $instanceName  = 'myapacheinstance',
  $url           = 'http://localhost/mod_status?auto'
) {

  configure_collectd_plugins::native_plugin { 'apache':
    package_name         => 'collectd-apache',
    plugin_file_name     => '10-apache.conf',
    plugin_template_name => 'apache.conf.erb'
  }
}
