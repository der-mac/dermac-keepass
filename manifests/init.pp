# == Class: keepass
#
# Install and configure the keepass-passwordmanagement-application (https://keepass.info).
#
# === Parameters
#
# [*package_ensure*]
#   Install or remove package
# [*$package_name*]
#   Name of the package in the operatingsystem
# [*$package_version*]
#   Keepass-version, which should be present on the system
# [*$download_link*]
#   Downloadlink for the keepass-version, which should be present on the system
# [*$install_dir*]
#   Install-directory for keepass (please do not change)
# [*$download_dir*]
#   Download-directory for the keepass-install-file
# [*$destination_file*]
#   Name of the downloaded keepass-install-file
# [*$download_cleanup*]
#   Remove the keepass-install-file once the installed version is the one
#   that should be installed
# [*$proxy_address*]
#   Proxy-server for the downlaod of the keepass-install-file
#   Have a look in the download_module documentation
# [*$proxy_user*]
#   Proxy-user for the downlaod of the keepass-install-file
#   Have a look in the download_module documentation
# [*$proxy_password*]
#   Proxy-passwort for the downlaod of the keepass-install-file
#   Have a look in the download_module documentation
# [*$is_password_secure*]
#   Switch to change the way that proxyPassword is interpreted from secure
#   string to plaintext.
#   Have a look in the download_module documentation
# [*$meta_preferuserconfiguration*]
#  KeePass Option
#  Switch to Change the possibillity to overide the configured global config
#  by the users
#  Set this to false to deploy an fixed central configuration
# [*$application_start_checkforupdate*]
#  KeePass Option
#  Swtich for the automatic Update-Check
#  Set this to false to deploy new versions only by puppet.
# [*$*]
#
# [*$*]
#
# [*$*]
#
# [*$*]
#
# === Variables
#
# === Examples
#
#  class { 'keepass': }
#
# === Authors
#
# Martin Schneider <martin@dermac.de>
#
# === Copyright
#
# Copyright 2017 Martin Schneider
#
class keepass (
  $package_ensure                   = $keepass::params::package_ensure,
  $package_name                     = $keepass::params::package_name,
  $package_version                  = $keepass::params::package_version,
  $install_dir                      = $keepass::params::install_dir,
  $download_link                    = $keepass::params::download_link,
  $download_dir                     = $keepass::params::download_dir,
  $download_cleanup                 = $keepass::params::download_cleanup,
  $destination_file                 = $keepass::params::destination_file,
  $proxy_address                    = $keepass::params::proxy_address,
  $proxy_user                       = $keepass::params::proxy_user,
  $proxy_password                   = $keepass::params::proxy_password,
  $is_password_secure               = $keepass::params::is_password_secure,
  $application_start_checkforupdate = $keepass::params::application_start_checkforupdate,
  $meta_preferuserconfiguration     = $keepass::params::meta_preferuserconfiguration,

) inherits keepass::params {

  validate_array($package_name)
  validate_string($package_version)
  validate_absolute_path($install_dir)
  validate_string($download_link)
  validate_absolute_path($download_dir)
  validate_bool($download_cleanup)
  validate_string($destination_file)
  validate_string($proxy_address)
  validate_string($proxy_user)
  validate_string($proxy_password)
  validate_bool($is_password_secure)
  validate_bool($application_start_checkforupdate)


  anchor { 'keepass::begin': }
  -> class { '::keepass::install': }
  -> class { '::keepass::config': }
  anchor { 'keepass::end': }

}
