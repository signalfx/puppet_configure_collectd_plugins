# mongodb plugin
#
class configure_collectd_plugins::plugins::mongodb (
  $hostname,
  $port,
  $user,
  $password,
  $database,
  $instance
) {

  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

  if $::osfamily == 'RedHat' {
    exec {'install epel-release': 
      command => 'yum install -y epel-release',
      before  => Package['python-pip']
    }
  }

  package { 'python-pip':
    ensure => present,
  }

  exec {'install mongodb py':
    command => 'pip install pymongo==3.0.3',
    require => Package['python-pip']
  }

  file { ['/usr/share/', '/usr/share/collectd/', '/usr/share/collectd/mongodb-collectd-plugin/']:
    ensure  => directory,
    before  => File['get mongodb typesdb'],
    require => Exec['install mongodb py']
  }

  file { 'get mongodb typesdb':
    ensure  => present,
    path    => '/usr/share/collectd/mongodb-collectd-plugin/mongodb_typesdb',
    owner   => root,
    group   => 'root',
    content => template('configure_collectd_plugins/mongodb_typesdb.erb'),
    before  => File['get mongodb python module'],
  }

  file { 'get mongodb python module':
    ensure  => present,
    path    => '/usr/share/collectd/mongodb-collectd-plugin/mongodb.py',
    owner   => root,
    group   => 'root',
    content => template('configure_collectd_plugins/mongodb.py.erb'),
  }

  configure_collectd_plugins::native_plugin { 'mongodb':
    package_name         => 'collectd-python',
    plugin_file_name     => '10-mongodb.conf',
    plugin_template_name => 'mongodb.conf.erb',
    require              => File['get mongodb python module']
  }

}
