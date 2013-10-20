class ecmanaged::ecm-systems {
}

class ecmanaged::ecm-systems::lamp($mysql_password='') {
	class { 'ecmanaged::ecm-apache::php': }
	class { 'ecmanaged::ecm-mysql::php': }
	class { 'ecmanaged::ecm-mysql::server':
		password => $mysql_password 
	} 
}

class ecmanaged::ecm-systems::lamp::hp($mysql_password='') {
	class { 'ecmanaged::ecm-apache::php::hp': }
	class { 'ecmanaged::ecm-mysql::php': }
	class { 'ecmanaged::ecm-mysql::server':
		password => $mysql_password
	} 
}

class ecmanaged::ecm-systems::lam($mysql_password='') {
	class { 'ecmanaged::ecm-apache': }
	class { 'ecmanaged::ecm-mysql::server':
		password => $mysql_password 
	} 
}

class ecmanaged::ecm-systems::lam::hp($mysql_password='') {
	class { 'ecmanaged::ecm-apache::hp': }
	class { 'ecmanaged::ecm-mysql::server':
		password => $mysql_password
	} 
}

