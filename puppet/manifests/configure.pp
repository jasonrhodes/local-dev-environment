include httpd
include build
include mysqld

file { '/var/www/html/index.php' :
    ensure => present,
    content => "<?php echo 'Internet unlocked: ' . date('Y m d : g m s');",
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