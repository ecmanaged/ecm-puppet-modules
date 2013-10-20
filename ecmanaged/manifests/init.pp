class ecmanaged {

	define wget ($uri, $timeout = 300) {
		exec {
		"download $uri":
				command => "wget -q '$uri' -O $name",
				creates => $name,
				timeout => $timeout,
				require => Package[ "wget" ],
		}
		package { ["wget"]:
		ensure => installed,
		}
	}

	define curl ($uri, $timeout = 300) {
		exec {
		"download $uri":
			command => "curl --output '$name' '$uri'",
			creates => $name,
			timeout => $timeout,
			require => Package[ "curl" ],
		path	=> ['/bin','/usr/bin','/sbin','/usr/sbin'];
		}
		package { ["curl"]:
		ensure => installed,
		}
	}

	define curl_post_localhost ($uri, $vhost, $data, $timeout = 300) {
		exec {
		"download $uri":
			command => "curl --output '$name' --data '$data' '$uri' -H 'Host:$vhost'",
			creates => $name,
			timeout => $timeout,
			require => Package[ "curl" ],
		path	=> ['/bin','/usr/bin','/sbin','/usr/sbin'];
		}
		package { ["curl"]:
		ensure => installed,
		}
	}

	define curl_post_vhost ($uri, $vhost, $data, $timeout = 300) {
		exec {
		"download $uri":
			command => "curl --output '$name' --data '$data' '$uri' -H 'Host:$vhost'",
			creates => $name,
			timeout => $timeout,
			require => Package[ "curl" ],
		path	=> ['/bin','/usr/bin','/sbin','/usr/sbin'];
		}
		package { ["curl"]:
		ensure => installed,
		}
	}

	file {'/var/backups':
		ensure => directory,
		mode => 0755
	}

	define motd ($text) {

		file {'/etc/motd':
			ensure	=> present,
			mode	=> 0644
		}
		file {'/etc/motd.tail':
			ensure  => present,
                        mode    => 0644
		}

		file_line {	'motd':
			path	=> '/etc/motd',
			line	=> $text,
			ensure => present,
		}

		 file_line {	'motd_tail':
			path	=> '/etc/motd.tail',
			line	=> $text,
			ensure => present,
		}
	}


	# Base class
	class { 'ecmanaged::ecm-base': }
}
