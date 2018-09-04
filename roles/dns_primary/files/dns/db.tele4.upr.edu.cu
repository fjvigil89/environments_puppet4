$ORIGIN .
$TTL 86400      ; 1 day
tele4.upr.edu.cu        IN SOA  tele4.upr.edu.cu. postmaster.upr.edu.cu. (
                                2018090401 ; serial
                                1h         ; refresh
                                1h         ; retry 
                                3h         ; expire
                                1h         ; TTL
                                )
                        NS      tele4.upr.edu.cu.
@       IN      NS      localhost.      ; delete this line
@       IN      A       127.0.0.1       ; delete this line
@       IN      AAAA    ::1             ; delete this line
