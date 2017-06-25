# == Class: keepass::config
#
# This is the config-class to configure the keepass-module
#
# === Parameters
#
# See the init-class.
#
# === Variables
#
# === Examples
#
# === Authors
#
# Martin Schneider <martin@dermac.de>
#
# === Copyright
#
# Copyright 2017 Martin Schneider
#
class keepass::config inherits keepass {
  ## Set OS-specific-values
  case $::os['name'] {
    'windows': {
      $keepass_global_config = "${keepass::install_dir}\\KeePass.config.xml"
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::os['name']} based system.")
    }
  }

  $ensure_file = $keepass::package_ensure ? {
    'absent' => absent,
    default  => file,
  }

  $ensure_dir = $keepass::package_ensure ? {
    'absent' => absent,
    default  => directory,
  }

  file { $keepass_global_config:
    ensure  => $ensure_file,
    content => template('keepass/KeePass.config.xml.erb'),
  }
}
