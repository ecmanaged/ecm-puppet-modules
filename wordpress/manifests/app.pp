class wordpress::app {

#  $wordpress_archive = 'wordpress-3.4.2.zip'
  $wordpress_archive = 'wordpress-3.5.1.zip'

  package { ['unzip']:
    ensure => latest
  }

  file {
    'wordpress_setup_files_dir':
      ensure  =>  directory,
      path    =>  "${wordpress::wp_install_dir}/setup_files",
      before  =>  File[
                      'wordpress_php_configuration',
                      'wordpress_themes',
                      'wordpress_plugins',
                      'wordpress_installer',
                      'wordpress_htaccess_configuration'
                      ];

    'wordpress_installer':
      ensure  =>  file,
      path    =>  "${wordpress::wp_install_dir}/setup_files/${wordpress_archive}",
      notify  =>  Exec['wordpress_extract_installer'],
      source  =>  "puppet:///modules/wordpress/${wordpress_archive}";

    'wordpress_php_configuration':
      ensure     =>  file,
      path       =>  "${wordpress::wp_install_dir}/wp-config.php",
      content    =>  template('wordpress/wp-config.erb'),
      subscribe  =>  Exec['wordpress_extract_installer'];

    'wordpress_htaccess_configuration':
      ensure     =>  file,
      path       =>  "${wordpress::wp_install_dir}/.htaccess",
      source     =>  'puppet:///modules/wordpress/.htaccess',
      subscribe  =>  Exec['wordpress_extract_installer'];

    'wordpress_themes':
      ensure     => directory,
      path       => "${wordpress::wp_install_dir}/setup_files/themes",
      source     => 'puppet:///modules/wordpress/themes/',
      recurse    => true,
      purge      => true,
      ignore     => '.svn',
      notify     => Exec['wordpress_extract_themes'],
      subscribe  => Exec['wordpress_extract_installer'];

    'wordpress_plugins':
      ensure     => directory,
      path       => "${wordpress::wp_install_dir}/setup_files/plugins",
      source     => 'puppet:///modules/wordpress/plugins/',
      recurse    => true,
      purge      => true,
      ignore     => '.svn',
      notify     => Exec['wordpress_extract_plugins'],
      subscribe  => Exec['wordpress_extract_installer'];

    'wordpress_vhost':
      ensure   => file,
      path     => "${wordpress::wp_install_dir}/wordpress.conf",
      source   => 'puppet:///modules/wordpress/wordpress.conf',
      replace  => true,
  }

  exec {
    'wordpress_extract_installer':
      command      => "unzip -o ${wordpress::wp_install_dir}/setup_files/${wordpress_archive} -d ${wordpress::wp_install_dir}",
      refreshonly  => true,
      require      => Package['unzip'],
      path	   => ['/bin','/usr/bin','/sbin','/usr/sbin'];

    'wordpress_extract_themes':
      command      => "/bin/sh -c \'for themeindex in `ls ${wordpress::wp_install_dir}/setup_files/themes/*.zip`; do unzip -o \$themeindex -d ${wordpress::wp_install_dir}/wp-content/themes/; done\'",
      refreshonly  => true,
      require      => Package['unzip'],
      subscribe    => File['wordpress_themes'];
 
    'wordpress_extract_plugins':
      command      => "/bin/sh -c \'for pluginindex in `ls ${wordpress::wp_install_dir}/setup_files/plugins/*.zip`; do unzip -o \$pluginindex -d ${wordpress::wp_install_dir}/wp-content/plugins/; done\'",
      refreshonly  => true,
      require      => Package['unzip'],
      subscribe    => File['wordpress_plugins'];
  }
}
