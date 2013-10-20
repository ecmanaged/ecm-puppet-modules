class drupal inherits pear {

  case $apache_www_folder {
    '': { fail("you need to define \$apache_www_folder for drupal module") }
  }

  case $apache_sites_folder {
    '': { fail("you need to define \$apache_sites_folder for drupal module") }
  }

  # We use drupal source from upstream 
  package { "drupal6":
      ensure => absent,
  }

  # Needed packages
  package { [ "drush", "php5-gd", "php5-imagick" ]:
      ensure => installed,
  }

  # Drupal management script
  file { "/usr/local/sbin/drupal":
    ensure  => present,
    content => template('drupal/drupal.sh.erb'),
    owner   => root,
    group   => root,
    mode    => 755,
  }

  # Run drupal cron
  cron { "drupal-cron":
    command  => "/usr/local/sbin/drupal cron &> /dev/null",
    user     => root,
    hour     => "*/1",
    minute   => "15",
    ensure   => present,
    require  => File['/usr/local/sbin/drupal'],
  }

  # Drupal shared folder
  file { "/usr/local/share/drupal":
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => 755,
  }

  # Drupal 6 makefile
  file { "/usr/local/share/drupal/drupal6.make":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/drupal/drupal6.make",
    require => File['/usr/local/share/drupal'],
  }

  # Drupal 7 makefile
  file { "/usr/local/share/drupal/drupal7.make":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/drupal/drupal7.make",
    require => File['/usr/local/share/drupal'],
  }

  # Drupal 6 theme makefile
  file { "/usr/local/share/drupal/themes6.make":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/drupal/themes6.make",
    require => File['/usr/local/share/drupal'],
  }

  # Drupal 7 theme makefile
  file { "/usr/local/share/drupal/themes7.make":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/drupal/themes7.make",
    require => File['/usr/local/share/drupal'],
  }
}
