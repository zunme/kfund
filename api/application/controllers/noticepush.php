<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
define("GOOGLE_SERVER_KEY", "AAAAmq2GQkU:APA91bFL-UWp-P8DCWFQaeqCokUdwqtC2U8YPxTqS8_xT_9dZ-EImsmRmlEBTzz_0k8_p5hqfm7p9DkiCBc4_llydXHxzt7uMgfCun-Z-7UZJVxSzyrJUVklNHjkIvjaYjDE5KgaoEWI");
class Noticepush extends CI_Controller {
  function index() {
    $this->db = $this->load->database('real',true);
    if ( $this->input->post('token') == '' ) {
      echo json_encode( array('code'=>500) );return;
    }
    $row = array();
    if( $this->input->post('pushid') != '' )  {
      $row = $this->db->get_where('z_notice_pushid',array('token'=>$this->input->post('pushid') ) )->row_array();
    }
    if(isset($row['idx']) ){
      $this->db
        ->set('token', $this->input->post('token') )
        ->where('token', $this->input->post('pushid') )
        ->update('z_notice_pushid' );
    }else {
      $this->db->insert('z_notice_pushid', array('token'=>$this->input->post('token') ) );
    }
    echo json_encode( array('code'=>200) );
  }
  function notice() {
    $this->db = $this->load->database('real',true);
    $sql = "select token from z_notice_pushid where subscrib='Y' and deleted='N' and uuid !='' limit 1000";
    $rows = $this->db->query($sql)->result_array();
    $ids = array();
    foreach($rows as $row) $ids[] = $row['token'];
      $this->send_fcm("test", $ids);
    return;
    $rows = $this->db->get_where ('z_notice_pushid', array('subscrib'=>'Y') )->result_array();
    foreach($rows as $row){
      if($row['uuid']=='') $this->send_fcm("test", $row['token'],true);
       else $this->send_fcm("test", $row['token']);
     }
  }
function token() {
  $this->db = $this->load->database('real',true);
  if( $this->input->post('uuid') != '' )  {
    $row = $this->db->get_where('z_notice_pushid',array('uuid'=>$this->input->post('uuid') ) )->row_array();
    if(isset($row['idx']) ){
      $this->db
        ->set('token', $this->input->post('token') )
        ->where('uuid', $this->input->post('uuid') )
        ->update('z_notice_pushid' );
    }else {
      $this->db->insert('z_notice_pushid', array('uuid'=>$this->input->post('uuid'),'token'=>$this->input->post('token') ) );
    }
    echo json_encode( array('code'=>200) );
  }else echo json_encode( array('code'=>201,'msg'=>'empty uuid') );
}
function curl_post_async($uri, $params)
  {
          $command = "curl ";
          foreach ($params as $key => &$val)
                  $command .= "-F '$key=$val' ";
          $command .= "$uri -s > /dev/null 2>&1 &";
          passthru($command);
  }
  private function send_fcm($message, $id, $isweb= false,$goto='main') {
    $url = 'https://fcm.googleapis.com/fcm/send';

    $headers = array (
    'Authorization: key=' . GOOGLE_SERVER_KEY,
    'Content-Type: application/json'
    );

    //$fields = '{"to":"'.$id.'","data": {"notification": {"title": "Hello","body": "world","click_action": "test"}}}';
    $payload = array('loadpage'=>$goto);
    $fieldsApp = array(
      'notification' => array (
        "title"=>$message,
        "body" => $message,
        "sound"=>"default"
      ),
      'data' => $payload,
       "priority"=>"high",
    );

    if(is_array($id)) {
      $fieldsApp['registration_ids'] = $id;
    } else {
      $fieldsApp['to'] = $id;
    }
    if($isweb) $fieldsApp['notification']['click_action'] = $goto;
    $fields = json_encode ($fieldsApp);

    //$fields='{  "notification":{    "title":"Notification title",    "body":"Notification body",    "sound":"default"  },  "data":{    "param1":"value1",    "param2":"value2"  },    "to":"'.$id.'",    "priority":"high",    "restricted_package_name":""}';
    //click_action
    $ch = curl_init ();
    curl_setopt ( $ch, CURLOPT_URL, $url );
    curl_setopt ( $ch, CURLOPT_POST, true );
    curl_setopt ( $ch, CURLOPT_HTTPHEADER, $headers );
    curl_setopt ( $ch, CURLOPT_RETURNTRANSFER, false );
    curl_setopt ( $ch, CURLOPT_POSTFIELDS, $fields );

    $result = curl_exec ( $ch );
    /*
    if ($result === FALSE) {
      die('FCM Send Error: ' . curl_error($ch));
    }
    var_dump($result);
    */
    curl_close ( $ch );
    return $result;
  }
}
