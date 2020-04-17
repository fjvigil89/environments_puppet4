node 'client-puppet.upr.edu.cu'{
  class { '::basesys':
    uprinfo_usage   	=> 'servidor test',
    application     	=> 'puppet',
    repos_enabled 	=> false,
    #dmz             => true,
    dns_preinstall 	=> true,

  }
$pack = ['python3-pip','build-essential','libssl-dev', 'libffi-dev','python3-dev','python3-venv']
ensure_packages($pack)

  exec{"stop_server_jupyther":
	# path 		=> "/bin:/sbin:/usr/bin:/usr/sbin",
    	command     	=> "source /root/environments/my_env/bin/activate && jupyter notebook  stop ",
  }~>
  exec{"start_server_jupyther":
	# path	 	=> "/bin:/sbin:/usr/bin:/usr/sbin",
    	command     	=> "source /root/environments/my_env/bin/activate && jupyter notebook --allow-root --ip=10.2.4.104 --no-browser  --NotebookApp.token='<none>'",
  }~>
notify{'jupyther':
    message =>  'Ejecutar en el navegador http://10.2.4.104:8888/?token=... ',
  }



}
