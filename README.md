# puppet_configure_collectd_plugins


#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with configure_collectd_plugins](#setup)
    * [What configure_collectd_plugins affects](#what-configure_collectd_plugins-affects)
4. [Usage - Configuration options and additional functionality](#usage)

## Overview

The configure_collectd_plugins module enables and configures a set of collectd plugins that work well with [SignalFx](http://signalfx.com).

This is one of three modules provided by SignalFx for managing collectd. See [Module Description](#module-description). 

## Module Description

Collectd is a system statistics collection daemon. This module configures collectd plugins to collect useful and interesting metrics about your system.

This is one of three modules provided by SignalFx for managing collectd. 

Module name | Description 
------------| ------------
[puppet_install_collectd](https://forge.puppetlabs.com/signalfx/install_collectd) | Install and stay up-to-date with SignalFx's latest build of collectd. 
configure_collectd_plugins | Enable and configure a set of collectd plugins that work well with SignalFx. 
[send_collectd_metrics](https://forge.puppetlabs.com/signalfx/send_collectd_metrics) | Configure collectd to send metrics to SignalFx. 

## Setup
Install the latest release of configure_collectd_plugins module from SignalFx using:
```shell
puppet module install signalfx/configure_collectd_plugins
```

### What configure_collectd_plugins affects

The configure_collectd_plugins module configures an existing instance of collectd to collect useful and interesting system metrics. You must have collectd installed in order to use this module. 

SignalFx provides additional modules to install collectd and send metrics to SignalFx. See [Module Description](#module-description). 

## Usage

The configure_collectd_plugins module accepts parameters that enable or disable each of the plugins that it configures. The default value for all parameters is 'present'. To disable data collection by a plugin, change the value of its named parameter to 'absent'. 

```shell
class { 'configure_collectd_plugins':
    log_file => present,
    aggregation => present,
    chain => present,
    cpu => present,
    cpufreq => present,
    df => present,
    load => present,
    memory => present,
    uptime => present,
    disk => present,
    interface => present,
    protocols => present,
    vmem => present
}
```

You can also use this module to install collectd plugins to monitor third-party software. To install a plugin, add its configuration snippet to your manifest file, and replace default configuration values with values that make sense for your environment as necessary. 


### Apache
```shell
class { 'configure_collectd_plugins::plugins::apache':
  instanceName  => 'myapacheinstance',
  url           => 'http://localhost/mod_status?auto'
}
```

Parameter | Description
----------|------------
instanceName | Appears as the dimension `plugin_instance` in SignalFx. 
url | The URL at which the plugin can read the output of Apache's mod_status module. 

### Cassandra
```shell
class { 'configure_collectd_plugins::plugins::cassandra':
  hostname => $::hostname
}
```

Parameter | Description
----------|------------
hostname | The name of the host running Cassandra. 

### Docker
```shell
include 'configure_collectd_plugins::plugins::docker'
```

### Elasticsearch
```shell
class { 'configure_collectd_plugins::plugins::elasticsearch':
  clustername         => 'elasticsearch',
  indexes             => '_all'
}
```

Parameter | Description
----------|------------
clustername | Appears as the dimension `plugin_instance` in SignalFx. 
indexes | Indexes to monitor using this plugin. All indexes are monitored by default. 

### Kafka version 0.8.2.1 and up
```shell
class { 'configure_collectd_plugins::plugins::kafka_82':
  hostname => $::hostname
}
```

Parameter | Description
----------|------------
hostname | The name of the host running Kafka. 

### Memcached
```shell
class { 'configure_collectd_plugins::plugins::memcached':
  hostname => '127.0.0.1',
  port     => '11211'
}
```

Parameter | Description
----------|------------
hostname | Name of the host on which memcached is running.
port | Port on which memcached is running. 

### MySQL
```shell
class { 'configure_collectd_plugins::plugins::mysql':
  hostname,
  user,
  password,
  database
}
```

Parameter | Description
----------|------------
hostname | Name of the host on which MySQL is running.
user | Username that collectd can use to connect to MySQL.
password | Password that collectd can use to connect to MySQL.
database | Name of the MySQL database to monitor. 

### Nginx
```shell
class { 'configure_collectd_plugins::plugins::nginx':
  url => 'http://localhost:80/nginx_status'
}
```

Parameter | Description
----------|------------
url | The URL at which collectd can read the output of nginx's stub status module. 

### PostgreSQL
```shell
class { 'configure_collectd_plugins::plugins::postgresql':
  hostname,
  user,
  password
}
```

Parameter | Description
----------|------------
hostname | Name of the host on which PostgreSQL is running.
user | Username that collectd can use to connect to PostgreSQL.
password | Password that collectd can use to connect to PostgreSQL.

### Redis Master
```shell
class { 'configure_collectd_plugins::plugins::redis_master':
  hostname,
  port
}
```
Use this configuration for Redis masters. 

Parameter | Description
----------|------------
hostname | Name of the host on which Redis is running.
port | Port on which Redis is running. 

### Redis Slave
```shell
class { 'configure_collectd_plugins::plugins::redis_slave':
  hostname,
  port
}
```

Use this configuration for Redis slaves. 

Parameter | Description
----------|------------
hostname | Name of the host on which Redis is running.
port | Port on which Redis is running. 

### Varnish
```shell
class { 'configure_collectd_plugins::plugins::varnish':
  hostname,
  port
}
```

Parameter | Description
----------|------------
hostname | Name of the host on which Varnish is running.
port | Port on which Varnish is running. 

### Zookeeper
```shell
include 'configure_collectd_plugins::plugins::zookeeper'
```
