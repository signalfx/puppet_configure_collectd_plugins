# elasticsearch plugin
#
class configure_collectd_plugins::plugins::elasticsearch (
        $clustername         = 'elasticsearch',
        $indexes              = '_all'
) {
  file { ['/usr/share/', '/usr/share/collectd/', '/usr/share/collectd/python/']:
    ensure => directory
  }

  file { 'get elasticsearch python module':
    ensure  => present,
    path    => '/usr/share/collectd/python/elasticsearch_collectd.py',
    owner   => root,
    group   => 'root',
    content => template('configure_collectd_plugins/elasticsearch_collectd.py.erb'),
    require => File['/usr/share/', '/usr/share/collectd/', '/usr/share/collectd/python/']
  }

  configure_collectd_plugins::native_plugin { 'elasticsearch':
    package_name         => 'collectd-python',
    plugin_file_name     => '10-elasticsearch.conf',
    plugin_template_name => 'elasticsearch.conf.erb',
    require              => File['get elasticsearch python module']
  }

}
