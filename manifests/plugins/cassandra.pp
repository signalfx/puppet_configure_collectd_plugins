# cassandra plugin
class configure_collectd_plugins::plugins::cassandra (
  $hostname = $::hostname
) {

  include configure_collectd_plugins::plugins::jmx

  configure_collectd_plugins::native_plugin { 'cassandra':
    plugin_file_name     => '20-cassandra.conf',
    plugin_template_name => 'cassandra.conf.erb'
  }

}
