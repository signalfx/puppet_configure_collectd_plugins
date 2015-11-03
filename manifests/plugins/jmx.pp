# jmx plugin
#
class configure_collectd_plugins::plugins::jmx (
) {
        $typesdbfile = "${conf_dir}/signalfx_types_db"

        if $::osfamily == 'Debian' {
          $conf_dir = '/etc/collectd/conf.d'
          $config_file = '/etc/collectd/collectd.conf'
        }
        elsif $::osfamily == 'Redhat' {
          $conf_dir = '/etc/collectd.d'
          $config_file = '/etc/collectd.conf'
        }

        file_line { 'Ensure collectd typesdb':
          ensure => present,
          line   => "TypesDB \"/usr/share/collectd/types.db\"",
          path   => $config_file,
          notify => Service['collectd']
        }

        file { 'Add signalfx typesdb':
          ensure  => present,
          path    => "${conf_dir}/signalfx_types_db",
          owner   => root,
          group   => 'root',
          mode    => '0640',
          content => template('configure_collectd_plugins/signalfx_types_db.erb'),
        }

        configure_collectd_plugins::native_plugin { 'jmx':
                package_name         => 'collectd-java',
                plugin_file_name     => '10-jmx.conf',
                plugin_template_name => 'jmx.conf.erb',
                #typesdbfile          => "${conf_dir}/signalfx_types_db",
                require              => File['Add signalfx typesdb']
        }
}
