class build {

    yumrepo { 'epel': 
        baseurl  => "http://dl.fedoraproject.org/pub/epel/6/x86_64",
        descr    => "Extra Packages for Enterprise Linux",
        enabled  => 1,
        gpgcheck => 0,
        before   => Yumrepo['ius'],
    }

    yumrepo { 'ius':
        baseurl  => "http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64",
        descr    => "IUS Community Release Repo",
        enabled  => 1,
        gpgcheck => 0,
    }

    package { 'php': 
        ensure => purged,
    }

    package { [
            "php-pear",
            "php-devel",
            "pcre-devel",
            "gcc",
            "make",
            "php-gd",
            "php-mbstring",
            "php-mcrypt",
            "php-domxml-php4-php5",
            "php-pecl-apc.x86_64"
          ]:
        ensure  => purged,
        require => Package['php'],
        before  => Package['php54'],
    }

    # package { 'libmcrypt' }

    package { 'php54':
        ensure => present,
        require => Yumrepo['ius'],
    }

    package { [
            'php54-cli',
            'php54-common',
            'php54-devel',
            'php54-gd',
            'php54-ldap',
            'php54-mbstring',
            'php54-mcrypt',
            'php54-mysql',
            'php54-pdo',
            'php54-pear',
            'php54-pecl-apc',
            'php54-xml',
        ]:
        ensure => present,
        require => Package['php54'],
    }

    package { "libssh2":
        ensure => present,
    }

    package { "java-1.6.0-openjdk":
        ensure => present
    }
}
