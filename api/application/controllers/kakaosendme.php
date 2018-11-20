<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class kakaosendme extends CI_Controller {
  public function _remap($method) {
    $this->restAPIKey = "e745adefbea5731ddb751ed16bd1e3e4"; // 본인의 REST API KEY를 입력해주세요
    $this->callbacURI = urlencode("https://www.kfunding.co.kr/api/kao"); // 본인의 Call Back URL을 입력해주세요
    $this->lineToken = "Ut0tk5SzSbudbNrIzjWil7a4zYaRx55OIGbg2o1zhUh";
    $this->{$method}();
  }
  function index() {

    if ( isset($_GET) && count($_GET) > 0 )
    {
      $code = $this->input->get('code');
      $this->getToken($code);
    }
  }
  function viewcache(){
    $this->load->driver('cache', array('adapter' => 'file'));
    var_dump( $this->cache->get('seyfert_time') );
  }

  function getToken($returnCode ){
    // API 요청 URL
    $returnUrl = "https://kauth.kakao.com/oauth/token?grant_type=authorization_code&client_id=".$this->restAPIKey."&redirect_uri=".$this->callbacURI."&code=".$returnCode;
    $isPost = false;
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $returnUrl);
    curl_setopt($ch, CURLOPT_POST, $isPost);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $headers = array();
    $loginResponse = curl_exec ($ch);
    $status_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close ($ch);
    $data = json_decode($loginResponse);
    $info = $this->getid($data);
    $tokeninfo = $this->getTokenInfo($data->access_token);

    $sql = "
    insert into z_ksession (id,nick, access_token, token_type, refresh_token, expires_in, expiredate )
    values (?,?,?,?,?,?,?)
    ON DUPLICATE KEY
    	UPDATE access_token = values( access_token ) ,
    				token_type = values( token_type ) ,
    				refresh_token = values( refresh_token ) ,
    				expires_in = values( expires_in ),
            expiredate = values( expiredate )
            ;
    ";
    $this->db->query($sql, array($info['id'],$info['properties']['nickname'], $data->access_token,$data->token_type,$data->refresh_token,$data->expires_in, $tokeninfo));

    echo"getID OK";
  }
  function getid($data){
    $USER_API_URL= "https://kapi.kakao.com/v2/user/me";
      $opts = array(
        CURLOPT_URL => $USER_API_URL,
        CURLOPT_SSL_VERIFYPEER => false,
        CURLOPT_SSLVERSION => 1,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => false,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_HTTPHEADER => array(
          "Authorization: Bearer " . $data->access_token
        )
      );

      $curlSession = curl_init();
      curl_setopt_array($curlSession, $opts);
      $accessUserJson = curl_exec($curlSession);
      curl_close($curlSession);

      return json_decode($accessUserJson, true);
  }
  function refreshToken($data=array()){
    $rows = $this->db->query("select * from z_ksession where expiredate <= date_add( now() ,interval 30 minute);")->result_array();
    //$rows = $this->db->query("select * from z_ksession where id='938416517' ")->result_array();
    foreach($rows as $info){
      $USER_API_URL= "https://kauth.kakao.com/oauth/token";

      $ch = curl_init();
      curl_setopt($ch, CURLOPT_URL, $USER_API_URL."?grant_type=refresh_token&client_id=".$this->restAPIKey."&refresh_token=".$info['refresh_token']);
      curl_setopt($ch, CURLOPT_POST, true);
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
      curl_setopt($ch, CURLOPT_HTTPHEADER, array("Authorization: Bearer " . $data->access_token, 'Content-Type: application/x-www-form-urlencoded'));
      $res = curl_exec ($ch);
      curl_close ($ch);
      $json = json_decode($res, true);
      $json['expiredate'] = $this->getTokenInfo($json['access_token']);
      var_dump($json);
      $up = $this->db->where('id',$info['id'])->update('z_ksession', $json);

    }
    return;
    //$param = array( "grant_type"=>"refresh_token", "client_id"=>$this->restAPIKey , "refresh_token"=>$info['refresh_token']);
  }
  function getTokenInfo($access_token=''){
    date_default_timezone_set('Asia/Seoul');
    $now = new DateTime();

    $access_token = ( $access_token =='' ) ? $this->input->get('token') : $access_token;
    $USER_API_URL= "https://kapi.kakao.com/v1/user/access_token_info";
      $opts = array(
        CURLOPT_URL => $USER_API_URL,
        CURLOPT_SSL_VERIFYPEER => false,
        CURLOPT_SSLVERSION => 1,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_HTTPHEADER => array(
          "Authorization: Bearer " . $access_token
        )
      );

      $curlSession = curl_init();
      curl_setopt_array($curlSession, $opts);
      $accessUserJson = curl_exec($curlSession);
      curl_close($curlSession);

      $res = json_decode($accessUserJson, true);

      $expire = (int)($res['expiresInMillis']/1000);
      //$res['expiredate'] = $now->add(new DateInterval('PT'.$expire.'S'))->format('Y-m-d H:i:s');
      var_dump($res);
      if ( $this->input->get('token') == $access_token) {
        echo $now->add(new DateInterval('PT'.$expire.'S'))->format('Y-m-d H:i:s');
      }
      else return $now->add(new DateInterval('PT'.$expire.'S'))->format('Y-m-d H:i:s');

  }
  function test() {

  }
  function payin(){
    $this->load->driver('cache', array('adapter' => 'file'));
    $seyfert_last= $this->cache->get('seyfert_last') ;
    if($seyfert_last < 1) $seyfert_last = '3132';
    $rows = $this->db->where('s_id >', $seyfert_last)->where ('trnsctnTp', 'SEYFERT_PAYIN_VACCNT')->where ('trnsctnSt', 'SFRT_PAYIN_VACCNT_FINISHED')
    ->get('mari_seyfert_order')->result_array();
    $msg = "";
    foreach($rows as $data){
      $msg .= number_format($data['s_amount'])." 원 입금 - ".$data['m_name']."(".$data['m_id'].")\n";
      $seyfert_last = $data['s_id'];
    }
    if($msg !=""){
      $sql = "
      select date_format(s_date,'%Y-%m-%d') as ymd, sum(s_amount) as total from mari_seyfert_order
      where
      s_date >= date_sub( curdate(), interval 1 day)
      and trnsctnSt='SFRT_PAYIN_VACCNT_FINISHED'
      group by date_format(s_date,'%Y-%m-%d')
      ";
      $rows = $this->db->query($sql)->result_array();
      foreach ( $rows as $info ){
        $msg .= $info['ymd']."일 총".number_format( $info['total'] )." \n";
      }
      //$this->msg($msg);
      $this->notify($msg);
      echo "send msg ( last - ".$seyfert_last." )";
    } else echo "none data";
    $this->cache->save('seyfert_last', $seyfert_last, 60000);
    $this->cache->save('seyfert_time', date("Y-m-d H:i:s"), 60000);
  }
  function loanprg(){
    $this->load->driver('cache', array('adapter' => 'file'));
    $sql = "select
      b.loan_id
      , b.i_subject
      , a.i_invest_pay
      , ifnull( count(1) , 0) as cnt
      , sum(i_pay) as total
      , sum( if ( m_id = 'test@test.com', 0 , 1) ) as real_cnt
      , sum( if ( m_id = 'test@test.com', 0 , i_pay) ) as real_total

      , sum( if ( m_id = 'test@test.com', 1 , 0) ) as virt_cnt
      , sum( if ( m_id = 'test@test.com', i_pay, 0 ) ) as virt_total

      from (select loan_id, i_invest_pay from mari_invest_progress where i_id > 13 and i_look = 'Y') a
      join mari_invest b on a.loan_id = b.loan_id
      group by b.loan_id";
      $rows = $this->db->query($sql)->result_array();
      $msg = "";
      if( count($rows)> 0 ){
        foreach($rows as $info){
          $loaninfo = $this->cache->get('loan_total_'.$info['loan_id']) ;
          //$loaninfo = false;
          if(!$loaninfo){
            $loaninfo = array('real_cnt'=>0, 'real_total');
          }
          if ( $info['real_total'] != $loaninfo['real_total'] ||  $info['real_total'] != $loaninfo['real_total'] ) {
            $tmp = explode( ']' , $info['i_subject']);
            $title = $tmp[0].']';
            $msg .= "투자진행변경\n";
            $msg .= $title." 실: ".number_format($info['real_total'])."원 , 가상:".number_format($info['virt_total'])."원 진행중\n";
            $msg .=(( $info['total'] > 0 )  ? round ($info['total'] / $info['i_invest_pay']*100) : "0" )."% 진행중 - 총 : ".$info['total']."원\n";
            //$this->msg($msg,'L');
            $this->notify($msg);
          }
          $this->cache->save('loan_total_'.$info['loan_id'], $info, 600000);
        }
      }
  }
  function msg($msg, $sendtype="I") {
    $USER_API_URL= "https://kapi.kakao.com/v2/api/talk/memo/default/send";
    $link = urlencode("https://www.kfunding.co.kr/api/index.php/admpop/ipgum");
    $rows = $this->db->query("select * from z_ksession where sendtype = 'A' or sendtype = ? ", array($sendtype))->result_array();
    foreach($rows as $info){
      $data = urlencode(json_encode(array("object_type"=>"text", "text"=>$msg, "link"=>array("web_url"=>$link, "mobile_web_url"=>$link), "button_title"=>"확인")));
      $ch = curl_init();
      curl_setopt($ch, CURLOPT_URL, $USER_API_URL."?template_object=".$data);
      curl_setopt($ch, CURLOPT_POST, true);
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
      curl_setopt($ch, CURLOPT_HTTPHEADER, array("Authorization: Bearer " . $info['access_token'], 'Content-Type: application/x-www-form-urlencoded'));
      $res = curl_exec ($ch);
      curl_close ($ch);
      $return_json = json_decode($res, true);
    }
  }
  function notify($msg="sendmessage.."){
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, "https://notify-api.line.me/api/notify?message=".urlencode($msg));
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array("Authorization: Bearer " . $this->lineToken, 'Content-Type: application/x-www-form-urlencoded'));
    //curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
    $res = curl_exec ($ch);
    curl_close ($ch);
    $return_json = json_decode($res, true);
    var_dump($return_json);
  }
  function login() {
    ?>
    <!DOCTYPE html>
    <html>
    <head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
    <title>Login Demo - Kakao JavaScript SDK</title>
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

    </head>
    <body>
    <a id="kakao-login-btn"></a>
    <a href="http://developers.kakao.com/logout"></a>
    <a href="https://kauth.kakao.com/oauth/authorize?client_id=<?php echo $this->restAPIKey ?>&redirect_uri=<?php echo $this->callbacURI?>&response_type=code">로그인하기</a>
    </body>
    </html>
    <?
  }
}
/*
CREATE TABLE `z_ksession` (
	`id` INT(11) NOT NULL,
	`nick` VARCHAR(50) NOT NULL DEFAULT '',
	`sendtype` ENUM('A','I','L','N') NOT NULL DEFAULT 'L',
	`access_token` VARCHAR(255) NOT NULL,
	`token_type` VARCHAR(20) NOT NULL,
	`refresh_token` VARCHAR(255) NOT NULL,
	`expires_in` VARCHAR(255) NOT NULL,
	`last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;
*/
