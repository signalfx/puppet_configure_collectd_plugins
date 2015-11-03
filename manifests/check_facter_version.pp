# Check for the facter version and report error if it is below 1.6.18
#
class configure_collectd_plugins::check_facter_version {

  if versioncmp($::facterversion, '1.6.18') <= 0 and $::operatingsystem == 'Amazon' {
    fail("Your facter version ${::facterversion} is not supported by our module. more info can be found at https://support.signalfx.com/hc/en-us/articles/205675369")
  }

}
