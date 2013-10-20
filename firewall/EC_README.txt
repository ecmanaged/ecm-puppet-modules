http://geek.jasonhancock.com/2011/10/11/managing-iptables-firewalls-with-puppet/
http://uncommonsense-uk.com/2012/moving-from-puppet-iptables-to-puppet-firewall/


class myfirewall {
 
    $ipv4_file = $operatingsystem ? {
        "debian"          => '/etc/iptables/rules.v4',
        /(RedHat|CentOS)/ => '/etc/sysconfig/iptables',
    }
 
    exec { "purge default firewall":
        command => "/sbin/iptables -F && /sbin/iptables-save > $ipv4_file && /sbin/service iptables restart",
        onlyif  => "/usr/bin/test `/bin/grep \"Firewall configuration written by\" $ipv4_file | /usr/bin/wc -l` -gt 0",
        user    => 'root',
    }
 
    /* Make the firewall persistent */
    exec { "persist-firewall":
        command     => "/bin/echo \"# This file is managed by puppet. Do not modify manually.\" > $ipv4_file && /sbin/iptables-save >> $ipv4_file", 
        refreshonly => true,
        user        => 'root',
    }
 
    /* purge anything not managed by puppet */
    resources { 'firewall':
        purge => true,
    }
 
    firewall { "001 accept all icmp requests":
        proto => 'icmp',
        jump  => 'ACCEPT',
    }
 
    firewall { '002 INPUT allow loopback':
        iniface => 'lo',
        chain   => 'INPUT',
        jump    => 'ACCEPT',
    }
 
    firewall { '000 INPUT allow related and established':
        state => ['RELATED', 'ESTABLISHED'],
        jump  => 'ACCEPT',
        proto => 'all',
    }
 
    firewall { '100 allow ssh':
        state => ['NEW'],
        dport => '22',
        proto => 'tcp',
        jump  => 'ACCEPT',
    }
 
    firewall { "998 deny all other requests":
        jump   => 'REJECT',
        proto  => 'all',
        reject => 'icmp-host-prohibited',
    }
 
    firewall { "999 deny all other requests":
        chain  => 'FORWARD',
        jump   => 'REJECT',
        proto  => 'all',
        reject => 'icmp-host-prohibited',
    }
}
