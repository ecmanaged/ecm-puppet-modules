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

define ecmanaged::ecm-nginx::vhost(
  $ensure                 = 'enable',
  $listen_ip              = '*',
  $listen_port            = '80',
  $index_files            = ['index.html', 'index.htm', 'index.php'],
  $server_name            = [$name],
  $www_root               = undef,
) {

  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

}

