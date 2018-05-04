<p>
	<h2>Para usar los branchs de git se usa</h2>
</p>
<pre>
/opt/puppetlabs/puppet/bin/r10k deploy environment -p
</pre>

<p>
	<h4>Con esto se instalan los modulos automaticamente desde Puppetfile</h4>
</p>

<p>
        <h2>Configuracion de envirinment.conf</h2>
</p>
<pre>
 manifest =  $confdir/environments/$environment/manifests/site.pp
 modulepath = roles:profiles:modules:$basemodulepath
</pre>

sudo config:

# Gitlab ci user can deploy puppet code
gitlabci ALL=(ALL) NOPASSWD:/usr/local/bin/r10k


**Create git clone in this proyect
* se clona el proyecto principal
git clone git@git.upr.edu.cu:dcenter/environments.git

* se copia la rama production del principal 
git checkout -a production

* se accede a dicha rama production
git checkout production

* se elimina la rama master para empesar el trabajo con puppet
git branch -D master

* se crea nueva rama para el trabajo del environment
git checkout -b <new branch>



