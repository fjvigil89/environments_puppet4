<?php 
function sendFailureMessage($message){
$EMAIL="di@upr.edu.cu";
$MENSAJE='PAP Sync FAIL on '.date('l jS \of F Y h:i:s A').($message?' With message: '.$message:'');
$ASUNTO="Sync AD to PAP FAIL";

mail($EMAIL,$ASUNTO, $MENSAJE);
echo "MAIL FAILURE SENT";

}


try{



/*********** AD GROUPS SYNC ****************/
/*
USAGE: 
php ad-to-pap.php
*/

// config params 

#define('ldap_host' , "ldap://ad.upr.edu.cu");
define('ldap_host' , "ldap://10.2.24.35");
define('ldap_dom',"@upr.edu.cu"); 
define('ldap_dn',"DC=upr,DC=edu,DC=cu");

define('user','ras');
define('password','P@ssword');

$totalUsersWithRas = 0;

function getMembers($groupCN, $members =  array()){
    global $totalUsersWithRas;
    $results = ldap_search(ldap,ldap_dn,$query='memberof='.$groupCN);
    $member_list = ldap_get_entries(ldap, $results);
    $group_member_details = array();
    foreach($member_list as $key=>$member) {
        if (!is_array($member)) continue;
        $totalUsersWithRas++;
        $member_details = $member;
        if ($member_details['useraccountcontrol'][0]==66050){
            echo "Skipping disabled user ".$member_details['samaccountname'][0].PHP_EOL;
            continue;
        }

        $phones = '';
        // field in tab General 
        if (array_key_exists('telephonenumber', $member_details)) $phones.= $member_details['telephonenumber'][0];
        //if (array_key_exists('revision', $member_details)) $phones.=',' $member_details['revision'][0];
        // all fields in tab Telephones
        if (array_key_exists('homephone', $member_details))  $phones.= ','.$member_details['homephone'][0];
        if (array_key_exists('pager', $member_details))  $phones.= ','.$member_details['pager'][0];
        if (array_key_exists('mobile', $member_details))  $phones.= ','.$member_details['mobile'][0];
        if (array_key_exists('facsimiletelephonenumber', $member_details))  $phones.= ','.$member_details['facsimiletelephonenumber'][0];
        if (array_key_exists('ipphone', $member_details))  $phones.= ','.$member_details['ipphone'][0];

        if ($phones && !empty($phones))
            $group_member_details[] = array('username'=>($username=$member_details['samaccountname'][0]),'phones'=>$phones);
    }

    return $group_member_details;
}
$ldap = ldap_connect(ldap_host,389) or sendFailureMessage('Cant connect to ldap');
define('ldap',$ldap);
ldap_set_option(ldap, LDAP_OPT_REFERRALS, 0);
ldap_set_option(ldap, LDAP_OPT_PROTOCOL_VERSION, 3);
@ldap_bind(ldap, user . ldap_dom, password) or sendFailureMessage('Cant bind to ldap');

echo sprintf("%s", <<<EOF
# This file its auto generated
# 
EOF
);
echo "### STARTING SYNC WITH AD FOR PAP RADIUS ON ".date('l jS \of F Y h:i:s A')."  #########################".PHP_EOL;
echo "## LISTING GROUP UPR-Ras USERS  ########".PHP_EOL;
// connect to db 
mysql_connect("localhost", "root", "freeradius.upr2k18") or sendFailureMessage(mysql_error());
// select db
mysql_select_db("radius") or sendFailureMessage(mysql_error()); 
// empty current records 
mysql_query("delete FROM radcheck WHERE attribute='Calling-Station-Id'") 
 or sendFailureMessage(mysql_error()); 

$total = 0;
$full = getMembers('CN=UPR-Ras,OU=_Gestion,DC=upr,DC=edu,DC=cu');
$total_users = count($full);
foreach ($full as $p){
    if (!$p['phones'] || $p['phones'] == '') continue;
    // get comma separated phones 
    $phones =explode(',', $p['phones']);
    foreach ($phones as $ph){
    	if (!$ph || empty($ph)) continue;
        mysql_query(sprintf("insert into radcheck (username, attribute, op, value ) VALUES ('%s','Calling-Station-Id','+=','%s')", $p['username'],$ph))
        or sendFailureMessage(mysql_error()); 
        echo sprintf('Pushing to db user %s with phone %s', $p['username'],$ph).PHP_EOL; // taking to console some logs 
        $total++;
    }
}


echo PHP_EOL;
echo PHP_EOL;
echo '******';
echo '*';
echo '* SINCRONIZADOS '.$totalUsersWithRas.' Usuarios con RAS';
echo '*';
echo '******';
echo PHP_EOL;
echo PHP_EOL;

ldap_close(ldap);


} catch(Exception $e){

    sendFailureMessage($e->getMessage());
//$EMAIL="di@upr.edu.cu";
//$MENSAJE='Count '.$total_ras_internet.' users by RAS-INTERNET  '.date('l jS \of F Y h:i:s A');
//$ASUNTO="Count Internet RAS";

//mail($EMAIL,$ASUNTO, $MENSAJE);


}
