class ecmanaged::ec-systems {
}

class ecmanaged::ec-systems::lamp {
	class { 'ecmanaged::ec-apache': }
	class { 'ecmanaged::ec-apache::php': }
	class { 'ecmanaged::ec-mysql::php': }
	class { 'ecmanaged::ec-mysql::server':
		password => 'lalalala' 
	} 
}

class ecmanaged::ec-systems::lamp::hp {
	class { 'ecmanaged::ec-apache::hp': }
	class { 'ecmanaged::ec-apache::php::hp': }
	class { 'ecmanaged::ec-mysql::php': }
	class { 'ecmanaged::ec-mysql::server':
		password => 'lalalala' 
	} 
}
