# This module configures a collection of plugins that work well with SignalFx.
#
class configure_collectd_plugins (

        $log_file = present,
        $aggregation = present,
        $chain = present,
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
                ensure        => $log_file,
                log_level     => 'info',
                log_file      => '/var/log/signalfx-collectd.log',
                log_timestamp => true
  }

  collectd::plugin::aggregation::aggregator {
      'cpu':
          ensure                 => $aggregation,
          plugin                 => 'cpu',
          type                   => 'cpu',
          groupby                => ['Host', 'TypeInstance',],
          calculateaverage       => true,
          calculatesum           => true
  }

  class { 'collectd::plugin::chain':
        ensure             => $chain,
        chainname          => 'PostCache',
        defaulttarget      => 'write',
        rules              => [
          {
            'match'   => {
              'type'         => 'regex',
              'matches'      => {
                'Plugin'         => '^cpu$',
              },
          },
          'targets'   => [
            {
                'type'       => 'write',
                'attributes' => {
                  'Plugin'       => 'aggregation',
                },
            },
            {
              'type'         => 'stop',
            },
          ],
          },
        ],
    }

  class { 'collectd::plugin::disk':
    ensure         => $disk,
    disks          => ['/^loop\\d+/', '/^dm-\\d+/'],
    ignoreselected => true
  }

  class { 'collectd::plugin::interface':
    ensure         => $interface,
    interfaces     => ['/^lo\\d*$/', '/^docker.*/', '/^t(un|ap)\\d*/', '/^veth.*/'],
    ignoreselected => true
  }

  class { 'collectd::plugin::protocols':
    values         => ['Icmp:InDestUnreachs', 'Tcp:CurrEstab', 'Tcp:OutSegs', 'Tcp:RetransSegs', 'TcpExt:DelayedACKs', 'TcpExt:DelayedACKs', '/Tcp:.*Opens/', '/^TcpExt:.*Octets/'],
    ignoreselected => false
  }

  class { 'collectd::plugin::vmem':
    ensure  => $vmem,
    verbose => false
  }
}
