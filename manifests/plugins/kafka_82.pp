# kafka plugin
#
class configure_collectd_plugins::plugins::kafka_82 (
  $hostname = $::hostname
) {

  include configure_collectd_plugins::plugins::jmx

  configure_collectd_plugins::native_plugin { 'kafka_82':
    plugin_file_name     => '20-kafka_82.conf',
    plugin_template_name => 'kafka_82.conf.erb'
  }
}
