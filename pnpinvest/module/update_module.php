<?php
if( isset($_SERVER['HTTP_REFERER']) && $_SERVER['HTTP_REFERER'] !='' ) {
  $referearr = parse_url($_SERVER['HTTP_REFERER']);
  if( isset($referearr['host']) &&  $referearr['host'] !='fundingangel.co.kr' &&  $referearr['host'] !='nice.checkplus.co.kr' && $referearr['host'] !='cert.vno.co.kr' && $referearr['host'] != 'localhost'){
      $_SESSION['org_referer'] = $_SERVER['HTTP_REFERER'];
      $sqlt = "select * from z_referer where cookie = '".session_id()."' and regdate > SUBDATE(NOW(), INTERVAL 10 SECOND) limit 1";
      $rowt = sql_fetch($sqlt);
      if( $rowt == false ) {
        $sqlt = "insert into z_referer (depth, cookie, memid, referer) values ('2','".session_id()."', '".$memid."' , '". $_SERVER['HTTP_REFERER'] ."' )";
        sql_query($sqlt, FALSE);
      }
  }
}

if( isset($mode) && $mode !=''){
  switch ($mode) {
    case ("join4") :
      $joinipAddress = $_SERVER['REMOTE_ADDR'];
      if (array_key_exists('HTTP_X_FORWARDED_FOR', $_SERVER)) {
          $joinipAddress = array_pop(explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']));
      }
      $sqlt = "select mid from z_referer_join where mid = '".$_SESSION['joinmail']."' and regdate >= date_sub(now() ,interval 3 SECOND) limit 1";
      $rowt = sql_fetch($sqlt);
      if( !isset($rowt['mid']) ) {
        $sqlt = "insert into z_referer_join (mid, ip, referer) values ('".$_SESSION['joinmail']."', '".$joinipAddress."','".$_SESSION['org_referer']."')";
        sql_query($sqlt, FALSE);
      }
    break;
  }
}
if( isset($up) && $up !=''){
  switch ($up) {
    case "breaktest":
      echo "breaktest";
      break;
    case "join3":
       $_SESSION['joinmail'] = $_POST['m_id'];
      break;
    case "invest2":
      if ($type == "w") {
        /* START 동일차주 한도 체크 by lst 171124
            동일 차추 합산만 체크함
        */

        if (isset($user['m_id']) ) {
          $i_pay_module = (int)(preg_replace("/[^0-9]/", "", (string)$i_pay));
          include (getcwd().'/module/basic.php');
          $sameOwnerCheck = sameOwnerCheck ($user['m_id'], $loan_id);

          if( $sameOwnerCheck['totalpay'] > 0 && ((int)$i_pay_module + $sameOwnerCheck['totalpay'] >  $sameOwnerCheck['per_maximum']) ){
            $alert_str = '이미 동일 차주 상품인 \n [' . $sameOwnerCheck['i_subject'] . '] ';
            if( $sameOwnerCheck['cnt'] > 1) $alert_str .= ' ( 등 '.$sameOwnerCheck['cnt'].'개 ) ';
            $alert_str .= '\n 상품에 '. number_format($sameOwnerCheck['totalpay']) .'원을 투자하셨습니다.'.'\n';

            /* 총투자액과 총투자 한도 계산 해서 보여주기 , alert 내용은 미정 lst 171124
            $getMemberlimit = getMemberlimit($user['m_id']);
            $memberInvestmentNowProgress = memberInvestmentNowProgress($user['m_id']);
            $maxLimitInvest = $getMemberlimit['insetpay']-$memberInvestmentNowProgress['investProgressTotal'];
            $alert_str .= '\n 현재 투자진행중인 금액은 '.$memberInvestmentNowProgress['investProgressTotal'].'원이고'.'\n';
            $alert_str .= $getMemberlimit['invest_flag'].'의 투자한도는 '.$getMemberlimit['insetpay'].'원 입니다.'.'\n \n';

            $sameOwnerLimitWon =( $getMemberlimit['insetpay'] -$memberInvestmentNowProgress['investProgressTotal'] < $sameOwnerCheck['per_maximum'] - $sameOwnerCheck['totalpay'] ) ?
            $getMemberlimit['insetpay'] -$memberInvestmentNowProgress['investProgressTotal'] : $sameOwnerCheck['per_maximum'] - $sameOwnerCheck['totalpay'];
            $alert_str .= $sameOwnerLimitWon.'\n\n';
            */

            $alert_str .= "동일차주 상품에 투자 가능 금액은 현재 " .number_format( $sameOwnerCheck['per_maximum'] - $sameOwnerCheck['totalpay'] ) . '원 입니다.'.'\n';
            $alert_str .= '('.$sameOwnerCheck['member_level_label'].'의 동일차주포함 채권당 한도는 '. number_format($sameOwnerCheck['per_maximum']) .'원 입니다.)';
            alert($alert_str);exit;
          }
          else if ( (int)$i_pay_module > $sameOwnerCheck['per_maximum'] ){
            $alert_str .= "이 상품에 투자 가능 금액은 현재 " .number_format( $sameOwnerCheck['per_maximum'] - $sameOwnerCheck['totalpay'] ) . '원 입니다.'.'\n';
            $alert_str .= '('.$sameOwnerCheck['member_level_label'].'의 채권당 한도는 '. number_format($sameOwnerCheck['per_maximum']) .'원 입니다.)';
            alert($alert_str);exit;
          }else {
						$getMemberlimit = getMemberlimitbyloan($user['m_id'], $loan_id);
						$a_total = $getMemberlimit['avail'];
						$a_total2 = (int)$sameOwnerCheck['per_maximum'] - (int)$sameOwnerCheck['totalpay'];
						$available_total = ($a_total > $a_total2) ? $a_total2 : $a_total;

            if( (int)$i_pay_module > $available_total ) {
              $alert_str .= '현재 총투자진행중인 금액은 '.$memberInvestmentNowProgress['$available_total'].'원이고'.'\n';
              $alert_str .= $getMemberlimit['invest_flag'].'의 총투자한도는 '.number_format($getMemberlimit['insetpay']).'원 ,\n 채권당 한도는 '. number_format($sameOwnerCheck['per_maximum']) .'원 입니다.'.'\n \n';
              alert($alert_str);exit;
            }
          }
        }
        /* END 동일차주 한도 체크*/
      }
    break;
  }
}
