# docker plugin
class configure_collectd_plugins::plugins::docker (
) {
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

  if $::osfamily == 'RedHat' {
    exec { 'install epel-release':
      command => 'yum install -y epel-release',
      before  => Package['python-pip']
    }
  }

  package { 'python-pip':
    ensure => present,
  }

  exec {'install docker py':
    command => "pip install python-dateutil &&
                pip install docker-py &&
                pip install jsonpath_rw",
    require => Package['python-pip']
  }

  file { ['/usr/share/', '/usr/share/collectd/', '/usr/share/collectd/docker-collectd-plugin/']:
    ensure  => directory,
    before  => File['get docker typesdb'],
    require => Exec['install docker py']
  }

  if $::osfamily == 'Debian' {
    $config_file = '/etc/collectd/collectd.conf'
  }
  elsif $::osfamily == 'Redhat' {
    $config_file = '/etc/collectd.conf'
  }

  file_line { 'Ensure collectd typesdb':
    ensure => present,
    line   => "TypesDB \"/usr/share/collectd/types.db\"",
    path   => $config_file,
    notify => Service['collectd']
  }

  file { 'get docker typesdb':
    ensure  => present,
    path    => '/usr/share/collectd/docker-collectd-plugin/dockerplugin_typesdb',
    owner   => root,
    group   => 'root',
    content => template('configure_collectd_plugins/dockerplugin_typesdb.erb'),
    before  => File['get docker python module'],
  }

  file { 'get docker python module':
    ensure  => present,
    path    => '/usr/share/collectd/docker-collectd-plugin/dockerplugin.py',
    owner   => root,
    group   => 'root',
    content => template('configure_collectd_plugins/dockerplugin.py.erb'),
  }
  configure_collectd_plugins::native_plugin { 'docker':
    package_name         => 'collectd-python',
    plugin_file_name     => '10-docker.conf',
    plugin_template_name => 'docker.conf.erb',
    require              => File['get docker python module']
  }

}
