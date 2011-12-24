# == Class: jira
#
# Full description of class jira here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { jira:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#

#This class depends heavily on the installer behaviour.
#It's probably better to use this class to setup a jira instance to package up.
class jira::installer {
  $jiraVersion = "4.4.4-x32"
  $jiraInstallerFileName = "atlassian-jira-${jiraVersion}.bin"
  $jiraInstallDir = "/opt/atlassian/jira"

  file { 'responsefile':
    path    => "${jiraInstallDir}/.install4j/response.varfile",
    content => template('jira/response.varfile.erb'),   
  }
  
  file { 'atlassian-installer':
    path   => "/tmp/${jiraInstallerFileName}",
    source => "puppet:///modules/jira/${jiraInstallerFileName}",
    mode   => 755,
  }   

  exec { 'atlassian-installer-exec':
    command     => "/tmp/${jiraInstallerFileName}",
    refreshonly => true,
    subscribe   => File["atlassian-installer"],
  } 

}
