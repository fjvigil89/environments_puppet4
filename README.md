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

