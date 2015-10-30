# redis master plugin
#
class configure_collectd_plugins::plugins::redis_master (
  $hostname,
  $port
) {
  if ! defined( File['redis_plugin_directory'] ) {
    file { '/opt/redis-collectd-plugin/':
      ensure => directory
    }
    file { '/opt/redis-collectd-plugin/redis_info.py':
      ensure  => present,
      owner   => root,
      group   => 'root',
      content => template('configure_collectd_plugins/redis_info.py.erb'),
      require => File['/opt/redis-collectd-plugin/']
    }
  }



  configure_collectd_plugins::native_plugin { 'redis-master':
    package_name         => 'collectd-python',
    plugin_file_name     => '10-redis-master.conf',
    plugin_template_name => 'redis_master.conf.erb',
    require              => File['/opt/redis-collectd-plugin/redis_info.py']
  }

}
