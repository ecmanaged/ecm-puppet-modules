class ecmanaged::ecm-ntp {

	$ntp = $::osfamily ? {
          Debian => ntp,
          RedHat => ntp,
          default => ntp   
        }

	$ntpd = $::osfamily ? {
          Debian => ntp,
          RedHat => ntp,
          default => ntp   
        }

	package { $ntp: ensure => installed }
	service { $ntpd:
                ensure => running,
                enable => true,
                require => Package[$ntp],
        }
}
