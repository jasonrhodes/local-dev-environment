class mysqld {

    package { [
                "mysql",
                "mysql-server",
                "perl-DBD-MySQL",
              ]:
        ensure  => installed,
        require => Package['php54'],
    }

    service { "mysqld":
        enable     => true,
        ensure     => running,
        subscribe  => Package["mysql"],
    }

    exec { "grant-local-user":
        unless => "/usr/bin/mysql -ulocal -plocal",
        command => "/usr/bin/mysql -uroot -e \"GRANT ALL PRIVILEGES ON *.* TO 'local'@'localhost' IDENTIFIED BY 'local' WITH GRANT OPTION; FLUSH PRIVILEGES;\"",
        require => [Service["mysqld"]]
    }
}