class ecmanaged::ecm-firewall {}

class ecmanaged::ecm-firewall::clean {

	$ipv4_file = $osfamily ? {
		Debian  => '/etc/iptables/rules.v4', 
		RedHat  => '/etc/sysconfig/iptables',
		default	=> '/dev/null',
	}

	$ipv4_dir = $osfamily ? {
		Debian  => '/etc/iptables', 
		RedHat  => '/etc/sysconfig',
		default	=> '/etc/iptables',
	}

	file { "$ipv4_dir":
		ensure	=> directory,
		mode => 0755
	}
         
	exec { "clear-firewall":
		command => "/sbin/iptables -F && /sbin/iptables-save > $ipv4_file",
		user    => 'root',
		require	=> File["$ipv4_dir"]
	}
}

