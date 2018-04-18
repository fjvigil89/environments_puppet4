#!/usr/bin/perl
use Data::Dumper;
use JSON;
use YAML;
use WWW::Curl::Easy;

my $debug = 0;
my $url = "https://www.mgt.ugent.be/status/hostsexport.php";

my $curl = WWW::Curl::Easy->new;

$curl->setopt(CURLOPT_URL, "${url}");
$curl->setopt(CURLOPT_USERPWD, "foreman:aiDa4shi"); 
$curl->setopt(CURLOPT_SSL_VERIFYHOST,0);
$curl->setopt(CURLOPT_SSL_VERIFYPEER,0);

# A filehandle, reference to a scalar or reference to a typeglob can be used here.
my $response_body;
$curl->setopt(CURLOPT_WRITEDATA,\$response_body);

# Starts the actual request
my $retcode = $curl->perform;

# Looking at the results...
if ($retcode == 0) {
        print("Transfer went ok\n") if $debug > 0;
        my $response_code = $curl->getinfo(CURLINFO_HTTP_CODE);

        # judge result and next action based on $response_code
        print("Received response: $response_body\n") if $debug > 1;
        serverbeheer2hiera($response_body)

} else {
        # Error code, type of error, error message
        print("An error happened: $retcode ".$curl->strerror($retcode)." ".$curl->errbuf."\n");
        exit(1);
}

sub serverbeheer2hiera {
  my $data = shift;

  my %serverbeheer = ();
  my %hosts = ();
  #while(<$_>){
  foreach (split(/\n/, $data)){
    my $json = JSON->new;
    my $json_data = $json->decode($_);
    
    my %data = ();
    # header skippen 
    next if $json_data->{'naam'} eq '';

    # Serverbeheer status
    my $status = 'production';
    $status = 'test' if $json_data->{'events'} =~ /TEST/;
    $status = 'eol' if $json_data->{'events'} =~ /EOL/;
    $status = 'deployment' if $json_data->{'events'} =~ /Deployment/;
    $status = 'down' if $json_data->{'events'} =~ /DOWN/;
    $data{'status'} = $status;


    # Support informatie
    if(defined($json_data->{'supporttot'})){
      $data{'supporttot'} = $json_data->{'supporttot'}
    }
    if(defined($json_data->{'support'})){
      $data{'support'} = $json_data->{'support'}
    }
    
    $hosts{$json_data->{'naam'}} = \%data;
  }

  $serverbeheer{'serverbeheer'} = \%hosts;
  print Dump \%serverbeheer;
}
