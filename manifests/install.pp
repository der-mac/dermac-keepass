# == Class: keepass::install
#
# This is the install-class to install the keepass-application
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
class keepass::install inherits keepass {

  case $::os['name'] {
    'windows': {
      case $::os['release']['full'] {
        '7', '10': {
          # Check installed version against package-version
          if (versioncmp($keepass::package_version, String($::keepass_installed_version)) > 0) or ($::keepass_installed_version == '') {
            notify{"${keepass::package_name} :: Version is older, installing Software from ${keepass::download_link}": }

            # Downlaod install-file
            download_file { "${keepass::download_dir}\\${keepass::destination_file}":
              url                   => $keepass::download_link,
              destination_directory => $keepass::download_dir,
              destination_file      => $keepass::destination_file,
              proxy_address         => $keepass::proxy_address,
              proxy_user            => $keepass::proxy_user,
              proxy_password        => $keepass::proxy_password,
              is_password_secure    => $keepass::is_password_secure
            }

            # Install exe-file
            package { $keepass::package_name:
              ensure          => $keepass::package_ensure,
              source          => "${keepass::download_dir}\\${keepass::destination_file}",
              install_options => [ '/SILENT', '/SP-', '/SUPPRESSMSGBOXES', '/NORESTART', '/NOCLOSEAPPLICATIONS', '/NORESTARTAPPLICATIONS',
  '/LANG=german', '/TYPE=full', '/COMPONENTS="core,userdoc,keepasslibc,xsl,ngen,preload"', '/TASKS="fileassoc"' ],
              require         => Download_file["${keepass::download_dir}\\${keepass::destination_file}"],
            }
          }
          else {
            # If cleanup true, delete the install-file
            if ( $keepass::download_cleanup ) {
              file { "${keepass::download_dir}\\${keepass::destination_file}":
                ensure => absent,
              }
            }
          }
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
