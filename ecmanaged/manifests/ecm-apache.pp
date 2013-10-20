class ecmanaged::ecm-apache($mpm_module = 'worker') {
	class {'apache': 
		mpm_module => $mpm_module,
		default_mods => true,
		default_vhost => false,
	}
	
	file {'/var/www':
	        ensure => directory,
	        mode => 0755
	}

}

class ecmanaged::ecm-apache::hp {
	class {'ecmanaged::ecm-apache': }

	# Template for High Performance
	# Template uses:
	    # - $apache::params::user
	    # - $apache::params::group
	    # - $apache::params::conf_dir
	    # - $serveradmin

	include apache::params
	$serveradmin = 'root@localhost'
	file { "${apache::params::vdir}/ecmanaged.conf":
		ensure  => present,
		content => template('ecmanaged/ecm-apache/ecmanaged_hp.conf.erb'),
	}

}

class ecmanaged::ecm-apache::vhost_default {
	apache::vhost { "ecm-default":
	        priority                => '10',
	        vhost_name              => '*',
	        port                    => 80,
	        docroot                 => '/var/www',
	        logroot                 => '/var/log/apache2',
	        serveradmin             => "hostmaster@localhost",
	        serveraliases           => [],
	        docroot_owner           => 'root',
	        docroot_group           => 'root',
	        override                => 'All',
		options			=> '-Indexes FollowSymLinks',
	}

	file { '/var/www/index.html':
		ensure	=> present,
		content	=> template('ecmanaged/ecm-apache/ecmanaged_default_index.html.erb'),
		notify	=> Service["httpd"]
	}

}

class ecmanaged::ecm-apache::php {
	class {'ecmanaged::ecm-apache': 
		mpm_module => 'prefork',
	}
	class {'apache::mod::php': }

}

class ecmanaged::ecm-apache::php::hp {
	class {'ecmanaged::ecm-apache': 
		mpm_module => 'prefork',
	}
	class {'apache::mod::php': }

}

define ecmanaged::ecm-apache::passenger($vport,$docroot,$aliases) {
#	class {'ecmanaged::ecm-apache': }
	class {'apache':
                mpm_module => 'worker',
                default_mods => false,
                default_vhost => false,
        }

        class {'apache::mod::passenger': 
		passenger_high_performance  => 'on',
		rails_autodetect            => 'on',
	}
	ecmanaged::ecm-apache::vhost { "$name":
		vport 		=> $vport,
		docroot		=> $docroot,
		aliases		=> $aliases,
		custom_fragment	=> 'ecmanaged/ecm-passenger/vhost-passenger_fragment.conf.erb',
	}
}

define ecmanaged::ecm-apache::vhost($vport,$docroot,$aliases,$custom_fragment = '') {
	if ! defined(File[$docroot]) {
		file { "$docroot":
		        ensure => directory,
		        mode => 0755
		}
	}

	if $aliases == '' {
		$parsed_aliases = []
	} else {
		$parsed_aliases = []
		# puppet fucks!
		#$parsed_aliasessplit($aliases,"[,]")
	}

	host { "$name":
		ip => '127.0.0.1',
		host_aliases => $parsed_aliases
	}

	apache::vhost { "$name":
	        priority                => '10',
	        vhost_name              => '*',
	        port                    => $vport,
	        docroot                 => $docroot,
	        logroot                 => '/var/log/apache2',
	        serveradmin             => "hostmaster@$name",
	        serveraliases           => $parsed_aliases,
	        docroot_owner           => 'root',
	        docroot_group           => 'root',
	        override                => 'All',
		options			=> '-Indexes FollowSymLinks',
		custom_fragment		=> $custom_fragment
     	}
}

