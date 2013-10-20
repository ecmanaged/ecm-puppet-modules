define ecmanaged::ec-mysql {
	class { 'mysql': }
}

class ecmanaged::ec-mysql::server($password) {

	class { 'mysql::server':
	        config_hash => { 'root_password' => $password}
	}
	
	file {'/var/lib/mysql':
	        ensure	=> directory,
	        mode	=> 0755,
		require	=> Service['mysqld'],
	}
}

class ecmanaged::ec-mysql::server::hp($password) {

	class { 'mysql::server':
	        config_hash => { 'root_password' => $password}
	}
	
	file {'/var/lib/mysql':
	        ensure	=> directory,
	        mode	=> 0755,
		require	=> Service['mysqld'],
	}
}

define ecmanaged::ec-mysql::db($user,$password) {

	database { "$name":
	  ensure	=> present,
	  charset	=> 'utf8',
	  require       => Class['mysql::server','mysql::config']
	}

	# Por si creo mas de una ddbb con ese user
	if ! defined(database_user["$user@localhost"]) {
		database_user { "$user@localhost":
		  ensure	=> present,
		  password_hash	=> mysql_password("$password"),
		  require	=> Class['mysql::server','mysql::config']
		}
	
		database_grant { "$user@localhost/$name":
		  privileges	=> ['all'],
		  require	=> Class['mysql::server','mysql::config']
		}
	}
}

class ecmanaged::ec-mysql::php {

	$phpmysql = $::osfamily ? {
	  Debian => php5-mysql,
	  RedHat => php-mysql,
	  default => php-mysql
	}
	package { [$phpmysql]:
	  ensure => latest,
	}
}

#class { 'mysql::backup':
#        backupuser     => 'myuser2',
#        backuppassword => 'mypassword2',
#        backupdir      => '/var/backups',
#}
