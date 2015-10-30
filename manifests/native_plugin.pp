# common code for the 3rd party plugins
#
define configure_collectd_plugins::native_plugin (
  $plugin_file_name,
  $plugin_template_name,
  $package_name = '',
  $typesdbfile = ''
) {

  include 'configure_collectd_plugins::check_facter_version'
  include 'install_collectd'
  if $::osfamily == 'Debian' {
    $conf_dir = '/etc/collectd/conf.d'
  }
  elsif $::osfamily == 'Redhat' {
    $conf_dir = '/etc/collectd.d'
  }

  if $::osfamily == 'RedHat' and $package_name != '' {
    if ! defined( Package[$package_name] ) {
    package { $package_name:
      ensure => present,
      before => File["load ${plugin_file_name} plugin"]
    }
    }
  }

  file { "load ${plugin_file_name} plugin":
    ensure  => present,
    path    => "${conf_dir}/${plugin_file_name}",
    owner   => root,
    group   => 'root',
    mode    => '0640',
    content => template("configure_collectd_plugins/${plugin_template_name}"),
    notify  => Service['collectd'],
  }

}
