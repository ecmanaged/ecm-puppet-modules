class ecmanaged::ec-apache {
	class {'apache': }

	file {'/var/www':
	        ensure => directory,
	        mode => 0755
	}

}

class ecmanaged::ec-apache::hp {
	class {'ecmanaged::ec-apache': }

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

class ecmanaged::ec-apache::vhost_default {
	apache::vhost { "default":
	        priority                => '10',
	        vhost_name              => '*',
	        port                    => 80,
	        docroot                 => '/var/www',
	        logroot                 => '/var/log/apache2',
	        serveradmin             => "hostmaster@localhost",
	        serveraliases           => [],
	        configure_firewall      => false,
	        docroot_owner           => 'root',
	        docroot_group           => 'root',
	        override                => 'All',
		options			=> '-Indexes FollowSymLinks'
	}

	file { '/var/www/index.html':
		ensure	=> present,
		content	=> template('ecmanaged/ecm-apache/ecmanaged_default_index.html.erb'),
		notify	=> Service["httpd"]
	}

}

class ecmanaged::ec-apache::php {
	class {'apache::mod::php': }

}

class ecmanaged::ec-apache::php::hp {
	class {'apache::mod::php': }

}

define ecmanaged::ec-apache::vhost($vport,$docroot,$aliases,$template = '') {
	include apache::params
	if ! defined(File[$docroot]) {
		file { "$docroot":
		        ensure => directory,
		        mode => 0755
		}
	}

	host { "$name":
		ip => '127.0.0.1',
		host_aliases => $aliases
	}
	
	apache::vhost { "$name":
	        priority                => '10',
	        vhost_name              => '*',
	        port                    => $vport,
	        docroot                 => $docroot,
	        logroot                 => '/var/log/apache2',
	        serveradmin             => "hostmaster@$name",
	        serveraliases           => $aliases,
	        configure_firewall      => false,
	        docroot_owner           => 'root',
	        docroot_group           => 'root',
	        override                => 'All',
		options			=> '-Indexes FollowSymLinks',
		template		=> $template,
     	}

}
