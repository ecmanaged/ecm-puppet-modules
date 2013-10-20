class ecmanaged::ecm-nginx {
	package { nginx: ensure => installed }
        service { nginx:
                ensure => running,
                enable => true,
                hasrestart => true,
        }

	file {'/var/www':
	        ensure => directory,
	        mode => 0755
	}
}

