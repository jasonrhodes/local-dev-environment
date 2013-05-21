
# Default $PATH
Exec { path => '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin' }

include httpd
include build
include mysqld
include wpcli

file { '/var/www/html/index.php' :
    ensure => present,
    content => "<?php echo 'Internet unlocked:: ' . date('Y m d : g m s');",
    require => Package['httpd']
}

file { '/var/www/html/info.php' :
    ensure => present,
    content => "<?php phpinfo();",
    require => Package['httpd']
}

file { '/var/www/html/.htaccess' :
    ensure => present,
    content => "SetEnv APPLICATION_ENV \"development\"",
    require => Package['httpd']
}

exec { "set timezone":
  command => "/bin/ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime",
  refreshonly => true
}

# Default virtual host, should change contents
httpd::vhost { 'default':
    port    => 80,
    docroot => "/var/www/html",
}

httpd::vhost { 'test1.vhost':
    port    => 80,
    docroot => "/var/www/html/test1",
}

httpd::vhost { 'test2.vhost':
    port    => 80,
    docroot => '/var/www/html/test2',
}