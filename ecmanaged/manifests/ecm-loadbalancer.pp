class ecmanaged::ecm-loadbalancer {

	class {'ecmanaged': }

	$main_path = '/usr/local/ecmanaged/'
	$loadb_path = "$main_path/ecm-loadb-api"
	$loadb_git = 'https://github.com/ecmanaged/ecm-loadb-api'

	package { keepalived: ensure => installed }
	package { python-pip: ensure => installed }

	package { "flask":
		ensure => latest,
		provider => pip,
		require	=> PACKAGE['python-pip']
	}

	vcsrepo { "$loadb_path":
		ensure => present,
		provider => git,
		source => "$loadb_git",
		require => FILE["$main_path"],
		notify => FILE["$loadb_path/init.py"]
	}

	file { "$main_path":
                ensure  => directory,
		mode => 0750, owner => root, group => root,
        }	

	file { "$loadb_path/init.py":
                ensure  => present,
		mode => 0750, owner => root, group => root,
        }

	class { "ecmanaged::ecm-loadbalancer::daemon": 
		require	=> [VCSREPO["$loadb_path"],PACKAGE['flask','keepalived']]
	}

	service { keepalived:
		ensure => running,
		enable => true,
		require => Package["keepalived"],
	}

	exec {"reload-keepalived":
		command => "/etc/init.d/keepalived reload",
                refreshonly => true,
        }
	
	file { '/etc/keepalived/keepalived.conf':
        	ensure => present,
	        mode => '0644',
	        owner => 'root',
	        group => 'root',
	        tag => 'keepalived_config',
	        require => Package['keepalived'],
	        notify => Service['keepalived']
	}

	augeas { 'enable_ip_forwarding':
	        context => "/files/etc/sysctl.conf",
	        changes => "set net.ipv4.ip_forward 1",
	        notify => Exec['keepalived_apply_sysctl']
	}
	
	exec { 'keepalived_apply_sysctl':
        	command => '/sbin/sysctl -p',
        	refreshonly => true,
    	}

	exec { 'enable_ipvs_module_load':
        	command => '/bin/echo ip_vs >> /etc/modules',
        	unless => '/bin/grep -qF ip_vs /etc/modules'
	}

}

class ecmanaged::ecm-loadbalancer::daemon
{

	file { '/etc/init.d/ecm-loadb-api':
                ensure  => present,
                content => template('ecmanaged/ecm-loadbalancer/ecm-loadb-api.init.erb'),
		mode => 0750, owner => root, group => root,
                notify  => Service["ecm-loadb-api"]
        }

        service {
                ecm-loadb-api:
                        ensure => running,
                        enable => true,
                        hasstatus => true,
                        hasrestart => true,
			require => File['/etc/init.d/ecm-loadb-api'],
        }

}
