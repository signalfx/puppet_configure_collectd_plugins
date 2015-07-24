class configure_plugins (

	$log_file = present,
        $cpu = present,
        $cpufreq = present,
        $df = present,
        $load = present,
        $memory = present,
        $uptime = present,
        $disk = present,
        $interface = present,
        $protocols = present,
        $vmem = present

){
	include 'collectd'

	class { 'collectd::plugin::cpu':
                ensure => $cpu,
        }

        class { 'collectd::plugin::cpufreq':
                ensure => $cpufreq,
        }

        class { 'collectd::plugin::df':
                ensure => $df,
        }

        class { 'collectd::plugin::load':
                ensure => $load,
        }

        class { 'collectd::plugin::memory':
                ensure => $memory,
        }

        class { 'collectd::plugin::uptime':
                ensure => $uptime,
        }

	class { 'collectd::plugin::logfile':
                ensure => $log_file,
                log_level => 'info',
                log_file => '/var/log/signalfx-collectd.log',
                log_timestamp => true
        }
	
	class { 'collectd::plugin::disk':
		ensure => $disk,
		disks  => ["/^loop\d+$/", "/^dm-\d+$/"],
		ignoreselected => true
	}

	class { 'collectd::plugin::interface':
		ensure => $interface,
		interfaces     => ['/^lo\d*$/', "/^docker.*/", "/^t(un|ap)\d*$/", "/^veth.*$/"],
		ignoreselected => true
	}

# This plugin is not available in pdxcat/collectd module on puppetforge
# I will have to try alternate solutions
#	class { 'collectd::plugin::protocols':
#		values => ["Icmp:InDestUnreachs", "Tcp:CurrEstab", "Tcp:OutSegs", "Tcp:RetransSegs", "TcpExt:DelayedACKs", "TcpExt:DelayedACKs", "/Tcp:.*Opens/", "/^TcpExt:.*Octets/"],
#		ignoreselected => false
#	}

	class { 'collectd::plugin::vmem':
		ensure => $vmem,
		verbose => false
	}
}
