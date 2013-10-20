class pear::params {
  # @TODO: Add better defaults based on OS.
  $package = $::osfamily ? {
	  Debian => php-pear,
	  RedHat => php-pear,
	  default => php-pear
	}
}

