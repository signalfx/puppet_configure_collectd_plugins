# redis slave plugin
#
class configure_collectd_plugins::plugins::redis_slave (
  $hostname,
  $port
) {
  if ! defined( File['/opt/redis-collectd-plugin/'] ) {
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


  configure_collectd_plugins::native_plugin { 'redis-slave':
    package_name         => 'collectd-python',
    plugin_file_name     => '10-redis-slave.conf',
    plugin_template_name => 'redis_slave.conf.erb',
    require              => File['/opt/redis-collectd-plugin/redis_info.py']
  }

}
