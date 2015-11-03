# zookeeper plugin
#
class configure_collectd_plugins::plugins::zookeeper (
) {
  file { ['/opt/zookeeper-collectd-plugin/']:
    ensure => directory
  }

  file { 'get zookeeper python module':
    ensure  => present,
    path    => '/opt/zookeeper-collectd-plugin/zk-collectd.py',
    owner   => root,
    group   => 'root',
    content => template('configure_collectd_plugins/zk-collectd.py.erb'),
    require => File['/opt/zookeeper-collectd-plugin/']
  }

  configure_collectd_plugins::native_plugin { 'zookeeper':
    package_name         => 'collectd-python',
    plugin_file_name     => '20-zookeeper.conf',
    plugin_template_name => 'zookeeper.conf.erb',
    require              => File['get zookeeper python module']
  }

}
