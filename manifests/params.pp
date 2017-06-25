# == Class: keepass::params
#
# This is the paramter-class to configure the keepass-module
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
class keepass::params {

  $package_ensure                   = 'present'
  $download_dir                     = $::keepass_curr_temp_dir
  $download_cleanup                 = true
  $proxy_address                    = ''
  $proxy_user                       = ''
  $proxy_password                   = ''
  $is_password_secure               = false
  $application_start_checkforupdate = true
  $meta_preferuserconfiguration     = true

  $default_package_version    = '2.36'
  $default_package_name       = ['KeePass-2.36-Setup.exe']
  $default_download_link      = 'https://downloads.sourceforge.net/project/keepass/KeePass%202.x/2.36/KeePass-2.36-Setup.exe'
  $default_install_dir        = 'C:\Program Files (x86)\KeePass Password Safe 2'
  $default_destination_file   = 'keepass-latest.exe'

  case $::os['name'] {
    'windows': {
      case $::os['release']['full'] {
        '7', '10': {
          $package_version  = $default_package_version
          $package_name     = $default_package_name
          $download_link    = $default_download_link
          $install_dir      = $default_install_dir
          $destination_file = $default_destination_file
        }
        default: {
          fail("The ${module_name} module is not supported on Windows Version ${::os['release']['full']} based system.")
        }
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::os['name']} based system.")
    }
  }
}
