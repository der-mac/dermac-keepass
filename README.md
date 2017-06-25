# KeePass module for puppet

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with keepass](#setup)
    * [What keepass affects](#what-keepass-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with keepass](#beginning-with-keepass)
4. [Limitations](#limitations)

## Overview

The keepass-module installs the application KeePass and creates the global configuration.

## Module Description

With the keepass-module you can install and manage the application KeePass by downloading the given link and run the installer in silent mode.
This happens only if the installed version is older (or not present) than the version that should be installed.

The global configuration creates a central configuration for all users.
You can decide if let the user override these settings or not.

## Setup

### What keepass affects

The keepass-module downloads the installation-file to the temp-directory of the user running the puppet-agent.

### Setup Requirements

The keepass-module uses the puppet-download_file module

### Beginning with keepass

for a simple keepass-installation use:

```puppet
    class { "keepass" :
    }
```

To install a specific version of keepass on Windows:

```puppet
    class { "keepass" :
      package_version => '2.36',
      download_link => 'https://downloads.sourceforge.net/project/keepass/KeePass%202.x/2.36/KeePass-2.36-Setup.exe',
    }
```

To disable the global update-check:

```puppet
    class { "keepass" :
      application_start_checkforupdate => false,
    }
```

To disable the global update-check and deny the user to change the global options:

```puppet
    class { "keepass" :
      meta_preferuserconfiguration     => false,
      application_start_checkforupdate => false,
    }
```

## Limitations

At the Moment, only windows 7, windows 10 are supported.
