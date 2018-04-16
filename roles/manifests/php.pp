class roles::php {
	class { '::php':
	  ensure       => latest,
	  manage_repos => true,
	  fpm          => true,
	  dev          => true,
	  composer     => true,
	  pear         => true,
	  phpunit      => false,
	  settings   => {
	    'PHP/max_execution_time'  => '90',
	    'PHP/max_input_time'      => '300',
	    'PHP/memory_limit'        => '64M',
	    'PHP/post_max_size'       => '32M',
	    'PHP/upload_max_filesize' => '32M',
	    'Date/date.timezone'      => 'American/Havana',
	  },
	}
}
