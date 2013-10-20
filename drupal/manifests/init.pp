class drupal::drush {

  $drush_packages = $::osfamily ? {
	  Debian => ["wget","php5-gd","php5-xsl","php-pear"],
	  RedHat => ["wget","php-gd","php-xml","php-pear"],
	  default => ["wget","php-gd","php-dom","php-pear"],
	}

  package { $drush_packages:
    ensure => installed,
  }

  $drush_file="drush-8.x-6.0-rc4.tar.gz"

  exec { "download-drush":
    cwd => "/root",
    command => "/usr/bin/wget http://ftp.drupal.org/files/projects/$drush_file",
    creates => "/root/$drush_file",
    require =>  Package[$drush_packages]
  }

  exec { "install-drush":
    cwd => "/root",
    command => "/bin/tar xvzf /root/$drush_file",
    creates => "/root/drush",
    require => Exec["download-drush"],
  }


}

define drupal::install(
    $def_drupal_user='',
    $def_drupal_pass='',
    $def_drupal_title='',
    $def_drupal_email='',
    $def_db_name='',
    $def_db_user='',
    $def_db_password='',
    $def_install_dir='/var/www'
) {

  exec { "download-drupal":
    cwd => "$def_install_dir",
    command => "/root/drush/drush dl drupal-$name --destination=$def_install_dir --yes",
    creates => "$def_install_dir/drupal-$name",
    require => Class["drupal::drush"],
  }

  exec { "move-files1":
    cwd => "$def_install_dir",
    command => "/bin/mv $def_install_dir/drupal*/* $def_install_dir",
    require => Exec["download-drupal"],
  } 

  exec { "move-files2":
    cwd => "$def_install_dir",
    command => "/bin/mv $def_install_dir/drupal*/.htaccess $def_install_dir/",
    require => Exec["download-drupal"],
  } 
  
  exec { "clean-dir":
    cwd => "$def_install_dir",
    command => "/bin/rm -Rf $def_install_dir/drupal-$name",
    require => Exec["move-files1","move-files2"],
  }

  file { "drupal-conf-dir":
    path    => '/etc/drush',
    ensure  => 'directory',
    recurse => true,
  } 

  # hack to no send email after install (/etc/drush/drush.ini)
  file { "hack-sendmail":
    path    => "/etc/drush/drush.ini",
    owner   => root,
    group   => root,
    mode    => 644,
    content => "sendmail_path=/bin/true",
    require => File['drupal-conf-dir']
  }

  exec { "install-site":
    cwd => "$def_install_dir",
    command => "/root/drush/drush site-install standard --site-name='$def_drupal_title' --account-name='$def_drupal_user' --account-pass='$def_drupal_pass' --account-mail='$def_drupal_email' --db-prefix='drupal_' --db-url=mysql://'$def_db_user:$def_db_password@localhost/$def_db_name' --yes",
    require => [Exec["clean-dir"],File["hack-sendmail"]]
  }

#                      "cck",
# "weblinks"

  drupal::module { [ "admin_menu",

                     "comment_notify",
                     "contact_forms",
                     "filefield",
                     "google_analytics",
                     "imagecache",
                     "nodewords",
                     "views",
                     "views_attach",
                     "views_bulk_operations" ]: 
	def_install_dir => $def_install_dir,
	require		=> Exec["clean-dir"],
  }

}

define drupal::module($def_install_dir) {
  exec { "install-module-$name":
    cwd => "$def_install_dir",
    command => "/root/drush/drush dl $name",
  }
}

