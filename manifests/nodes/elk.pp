node 'elk.upr.edu.cu' {  
  
  class {'::elkserver':;}->
  class {'::filebeatserver':;}

  class {'metricbeatserver':;}


}
