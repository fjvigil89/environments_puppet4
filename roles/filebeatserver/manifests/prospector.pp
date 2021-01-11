define filebeatserver::prospector (
  Array[String] $paths               = [],
  String $doc_type                   = 'log',
  String $doc_name                   = 'logs',
){

    filebeat::prospector { $doc_name :
    paths    => $paths,
    doc_type => $doc_type,
  }


}
