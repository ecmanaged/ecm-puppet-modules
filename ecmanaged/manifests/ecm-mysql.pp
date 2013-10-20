define ecmanaged::ecm-mysql {
	class { 'mysql': }
}

#class { 'mysql::server': 
#  config_hash => { 
#    root_password => 'mypass', 
#    old_root_password => 'oldpass', 
#  } 
#} 

class ecmanaged::ecm-mysql::server($password) {
#	class { 'ecmanaged::ecm-base': }
	class { 'mysql::server':
		config_hash => { 'root_password' => $password}
	}
	
	file {'/var/lib/mysql':
		ensure	=> directory,
		mode	=> 0755,
		require	=> Service['mysqld'],
	}
}

class ecmanaged::ecm-mysql::server::hp($password) {
	class { 'mysql::server':
		config_hash => { 'root_password' => $password}
	}

	file {'/var/lib/mysql':
		ensure	=> directory,
		mode	=> 0755,
		require	=> Service['mysqld'],
	}
}

define ecmanaged::ecm-mysql::db($user,$password) {
	database { "$name":
		ensure		=> present,
		charset		=> 'utf8',
		require		=> Class['mysql::server','mysql::config']
	 
	}
	
	# Por si creo mas de una ddbb con ese user
	if ! defined(database_user["$user@localhost"]) {
		database_user { "$user@localhost":
			ensure		=> present,
			password_hash	=> mysql_password("$password"),
			require		=> CLASS['mysql::server','mysql::config',"database[$name]"],
		}
	}
	if ! defined(database_grant["$user@localhost/$name"]) {
		database_grant { "$user@localhost/$name":
			privileges	=> ['all'],
			require		=> CLASS['mysql::server','mysql::config',"database[$name]"],
		}
	}
}

class ecmanaged::ecm-mysql::php {
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
#	backupuser		 => 'myuser2',
#	backuppassword => 'mypassword2',
#	backupdir			=> '/var/backups',
#}
