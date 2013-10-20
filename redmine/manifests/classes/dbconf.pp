class redmine::dbconf {
	exec {
		'config_redmine_mysql_bootstrap':
			environment => 'RAILS_ENV=production',
			path => "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:$ruby::bin_dir",
			cwd => "$redmine::home",
			provider => shell,
			command => 'rake db:migrate',
			notify => Service["httpd"];
		'load_default_data':
			environment => ['RAILS_ENV=production', 'REDMINE_LANG=en'],
			path => "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:$ruby::bin_dir",
			cwd => "$redmine::home",
			provider => 'shell',
			command => 'rake redmine:load_default_data',
			notify => Service["httpd"];
	}
}
