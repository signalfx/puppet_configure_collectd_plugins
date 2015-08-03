# puppet_configure_collectd_plugins


#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with configure_collectd_plugins](#setup)
    * [What configure_collectd_plugins affects](#what-configure_collectd_plugins-affects)
4. [Usage - Configuration options and additional functionality](#usage)

## Overview

The configure_collectd_plugins module enables a collection of collectd configs that work well with SignalFx.

## Module Description

Collectd is a system statistics collection daemon. This module configures the collectd plugins like cpu, df, disk, interface etc with appropriate values so that you can collect only the interesting statistics.

Once you have installed this module, you may proceed to install [send_collectd_metrics](https://github.com/signalfx/puppet_send_collectd_metrics) puppet module from SignalFx to send metrics to SignalFx in one single and easy step.

## Setup
Install the latest release of configure_collectd_plugins module from SignalFx using:
```shell
puppet module install signalfx/configure_collectd_plugins
```

### What configure_collectd_plugins affects

The configure_collectd_plugins module configures the collectd so that it can only collect the system statistics. To be able to send data to SignalFx, please proceed on to the [send_collectd_metrics](https://github.com/signalfx/puppet_send_collectd_metrics) puppet module from SignalFx.

It is recommended to include the [install_collectd](https://github.com/signalfx/puppet_install_collectd) module before this module if you don't have any existing collectd on your systems to get the latest collectd from SignalFx repositories.

## Usage

The configure_collectd_plugins takes a bunch of parameters which enable and disable the plugins.
The default values to all the plugins are 'present'. You may change the value to 'absent' if you don't want any data to be collected by a plugin.

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


