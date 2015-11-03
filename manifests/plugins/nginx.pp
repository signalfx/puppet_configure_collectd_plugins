# nginx plugin
#
class configure_collectd_plugins::plugins::nginx (
        $url           = 'http://localhost:80/nginx_status'
) {
        configure_collectd_plugins::native_plugin { 'nginx':
                package_name         => 'collectd-nginx',
                plugin_file_name     => '10-nginx.conf',
                plugin_template_name => 'nginx.conf.erb'
        }

}
