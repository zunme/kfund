<?php
  /* 동일 차주 체크 */

  /* common_update_class.php #1234 line

  include (getcwd().'/module/basic.php');
  $sameOwnerCheck = sameOwnerCheck ($user['m_id'], $loan_id);
  if( (int)$i_pay + $sameOwnerCheck['totalpay'] >  $sameOwnerCheck['per_maximum'] ){
    $alert_str = '이미 동일 차주 상품인 [' . $sameOwnerCheck['i_subject'] . '] ';
    if( $sameOwnerCheck['cnt'] > 1) $alert_str .= ' ( 등 '.$sameOwnerCheck['cnt'].'개 ) ';
    $alert_str .= ' 상품에 '. number_format($sameOwnerCheck['totalpay']) .'원을 투자하셨습니다.'.'\n';
    $alert_str .= "현재 상품에 투자 가능 금액은 최대 " .number_format( $sameOwnerCheck['per_maximum'] - $sameOwnerCheck['totalpay'] ) . '원 입니다.';
    alert($alert_str);exit;

  }
  */
  function memberInvestmentNowProgress($mem){
    if(is_array($mem) && isset( $mem['m_id']) ) $mid =  $mem['m_id'];
    else if(trim($mem) =='') return array("cnt"=>0,"i_subject"=>"" );
    else $mid = $mem;
    $sql = "
    select ifnull(sum(i_pay),0) as investProgressTotal
    from mari_invest i
    join mari_invest_progress p on i.loan_id = p.loan_id and i_look in('Y','D','C')
    where i.m_id ='".$mid."' and i.i_regdatetime >= '2017-05-29 00:00:00'
    ";
    return sql_fetch($sql, false);
  }
  function sameOwnerCheck( $mem, $loanid ){
      return array_merge( isSameOwner ($mem, $loanid) , getMemberlimitInvest( $mem, $loanid ) );
  }
  /* 동일차주 내역 확인*/
  function isSameOwner ($mem, $loanid){
    if(is_array($mem) && isset( $mem['m_id']) ) $mid =  $mem['m_id'];
    else if(trim($mem) =='') return array("cnt"=>0,"i_subject"=>"" );
    else $mid = $mem;

    $sql = "
    select count(d.i_id) as cnt , d.i_subject, ifnull(sum(d.i_pay),0) as totalpay from
    (
    	(
    		select loan_id
    		from mari_loan_same_owner as a
    		join ( select parents_loan_id from mari_loan_same_owner where loan_id = ".$loanid." ) b on a.parents_loan_id = b.parents_loan_id
    	)
    	union
    	(select parents_loan_id as loan_id from mari_loan_same_owner where loan_id = ".$loanid." )
    ) sameloan
    join mari_invest_progress c on sameloan.loan_id = c.loan_id and i_view = 'Y' and i_look in ( 'Y', 'D' , 'C' ) #진행, 이자상환, 마감
    join mari_invest d on c.loan_id = d.loan_id and d.m_id = '".$mid."'
    ";
    //$row      = sql_query($sql, false);
    return sql_fetch($sql, false);
  }
  function levellist(){
    $data = array(
      'level_morethan_2'=>'법인회원'
      ,'N'=>'일반일반개인투자자'
      ,'L'=>'대출회원'
      ,'I'=>'소득적격투자자'
      ,'P'=>'전문투자자'
      ,'L2'=>'개인대부사업자투자자'
      ,'C2'=>'법인대부사업자투자자'
      ,'I2'=>'소득적격대부업자투자자'
    );
    return $data;
  }
  function isauthed($user,$pass=false){
    if(in_array($user['m_signpurpose'], array('P', 'I','L2','C2', 'I2' ) )  || $user['m_level'] =='3') {
      $sql = "select * from mari_member_auth where fk_mari_member_m_no = ".$user['m_no']." and authed='Y' limit 1";
      $tmp_member_is_authed = mysql_result(sql_query($sql, false), 0, 0);
      if( isset($tmp_member_is_authed['authed']) ) return array(true,'','');
      else {
        $levellist = levellist();
        $label =  ($user['m_level']=='3')? '법인회원':  $levellist[ $user['m_signpurpose'] ];
        return array(false,"회원인증 전 입니다.", $label.'임을 인증 할 서류는 <br><b>마이페이지 &gt; 회원정보수정</b> 에서 등록해주세요.');
      }
    }else if ($pass && $user['m_signpurpose'] =='L' ){
      return ( array(false,'대출회원은 투자가 불가능 합니다.','일반회원으로 가입후 투자를 진행해 주세요'));
    }
    return array(true,'','');
  }
  function isregnum($user){
    if( isset ($user['m_no'])) {
      $sql = "select m_reginum from mari_member where m_no = ".$user['m_no']." limit 1";
      $tmp = sql_fetch($sql, false);
      $reginum = (isset ($tmp['m_reginum']) && trim($tmp['m_reginum']) !='' ) ? true : false;
    } else $reginum = true;
    return $reginum;
  }
  function getMemberlimitbyloan2($mem,$loanid){
    //--------------------
        //일반유저만 테스트 중
        $sql = "
          select
           ifnull(sum(a.i_pay),0 ) total
           #부동산
           , ifnull(sum(case
               when( b.i_payment = 'cate02' || b.i_payment = 'cate04' ) then a.i_pay
               else 0
             end),0) as budongsan
           #동산
           , ifnull(sum(case
               when( b.i_payment = 'cate02' || b.i_payment = 'cate04' ) then 0
               else a.i_pay
             end),0) as dongsan
        #	, ifnull( tmp.payed,0) as payed
         from mari_invest a
         join mari_loan b on a.loan_id = b.i_id
        #	left join ( select v.loan_id, sum(wongum) as payed from view_jungsan v where v.sale_id = 'rjc1237@naver.com' group by loan_id ) tmp on a.loan_id = tmp.loan_id
         where a.m_id = '".$mid."' and b.i_look != 'F'
        ";
        $progress = sql_fetch($sql, false);
    //---------------

  }
  function getMemberlimitbyloan ($mem,$loanid){
    if ( is_array($mem) && isset( $mem['m_level'] ) && isset( $mem['m_signpurpose'] ) ) $user = $mem;
    else {
      $sql = "select * from mari_member where m_id ='".$mem."'";
      $user = sql_fetch($sql, false);
    }
    $sql = "select  * from  mari_inset";
    $is_ck = sql_fetch($sql, false);


    //--------------------
        $sql = "
          select
           ifnull(sum(a.i_pay),0 ) total
           #부동산
           , ifnull(sum(case
               when( b.i_payment = 'cate02' || b.i_payment = 'cate04' ) then a.i_pay
               else 0
             end),0) as budongsan
           #동산
           , ifnull(sum(case
               when( b.i_payment = 'cate02' || b.i_payment = 'cate04' ) then 0
               else a.i_pay
             end),0) as dongsan
        #	, ifnull( tmp.payed,0) as payed
         from mari_invest a
         join mari_loan b on a.loan_id = b.i_id
        	left join ( select v.loan_id, sum(wongum) as payed from view_jungsan v where v.sale_id = '".$user['m_id']."' group by loan_id ) tmp on a.loan_id = tmp.loan_id
         where a.m_id = '".$user['m_id']."' and b.i_look != 'F'
        ";
        $progress = sql_fetch($sql, false);

        $sql = "select i_payment from mari_loan where i_id ='".$loanid."'";
        $cate = sql_fetch($sql, false);
       //$maximum = $is_ck['i_maximum'];
       if ($cate['i_payment']=='cate02' || $cate['i_payment']=='cate04' ) {
           $cate_label = "부동산";
       }else {
         $cate_label = "비부동산";
       }
       $avail = -1 ;
    //---------------
    if($user['m_level'] >= "3" ) {
      $maximum = $is_ck['i_maximum_v'];
      $member_level_label ='법인회원투자자';
      if( $user['m_signpurpose']=='L'){
        $maximum = 0;
        $member_level_label ='법인대출회원';
      }
      $i_profit=$is_ck['i_profit_v'];//소득적격투자자
      $i_withholding=$is_ck['i_withholding_burr'];//소득적격투자자
      $i_withholding_v=$is_ck['i_withholding_burr_v'];//소득적격투자자
      //$is_ck['i_maximum_v']
    } //else if ($user['m_level'] == "2") {
      else {
         if ($user['m_signpurpose'] == "I") {
           $maximum = $is_ck['i_maximum_in'];
           $member_level_label = '소득적격투자자';
           $i_profit=$is_ck['i_profit_in'];//소득적격투자자
           $i_withholding=$is_ck['i_withholding_in'];//소득적격투자자
           $i_withholding_v=$is_ck['i_withholding_in_v'];//소득적격투자자
           //$is_ck['i_maximum_in']
         } else if ($user['m_signpurpose'] == "P") {
           $maximum = $is_ck['i_maximum_pro'];
           $member_level_label = '전문투자자';
           $i_profit=$is_ck['i_profit_pro'];//전문투자자
           $i_withholding=$is_ck['i_withholding_pro'];//전문투자자
           $i_withholding_v=$is_ck['i_withholding_pro_v'];//전문투자자
           //$is_ck['i_maximum_pro']
         } else if ($user['m_signpurpose'] == "L2") {
           $sql = "select i_payment from mari_loan where i_id ='".$loanid."'";
           $cate = sql_fetch($sql, false);
           //$maximum =($cate=='부동산') ? "10000000" : "20000000";//$is_ck['i_maximum'] ;
           //$maximum = $is_ck['i_maximum_personalloan'];

           if ($cate_label=='부동산') {
               $maximum = "10000000";
               if( $progress['total'] >= 10000000){
                 $avail = 0;
               }else{
                 $avail = $progress['budongsan'] >= 10000000 ? 0 : 10000000 - $progress['budongsan'];
                 $avail = (20000000 - $progress['total'] ) < $avail ? (20000000 - $progress['total'] ) : $avail;
               }
           }else {
             $maximum = "20000000";
             $avail = $progress['total'] >= 20000000 ? 0 : 20000000 - $progress['total'];
           }

           $member_level_label ='개인대부사업자투자자';
           $i_profit=$is_ck['i_profit_personalloan'];//개인대부사업자투자자
           $i_withholding=$is_ck['i_withholding_personalloan'];//개인대부사업자투자자
           $i_withholding_v=$is_ck['i_withholding_personalloan_v'];//개인대부사업자투자자
           //$is_ck['i_maximum_personalloan']
         } else if ($user['m_signpurpose'] == "C2") {
           $maximum = $is_ck['i_maximum_corporateloan'];
           $member_level_label ='법인대부사업자투자자';
           $i_profit=$is_ck['i_profit_corporateloan'];//법인대부사업자투자자
           $i_withholding=$is_ck['i_withholding_corporateloan'];//법인대부사업자투자자
           $i_withholding_v=$is_ck['i_withholding_corporateloan_v'];//법인대부사업자투자자
           //$is_ck['i_maximum_corporateloan']
         } else if ($user['m_signpurpose'] == "I2") {
           $maximum = $is_ck['i_maximum_incomeloan'];
           $member_level_label ='소득적격대부업자투자자';
           $i_profit=$is_ck['i_profit_incomeloan'];//소득적격대부투자자
           $i_withholding=$is_ck['i_withholding_incomeloan'];//소득적격대부투자자
           $i_withholding_v=$is_ck['i_withholding_incomeloan_v'];//소득적격대부투자자
           //$is_ck['i_maximum_incomeloan']
         }
         //if ($user['m_signpurpose'] == "N" || $user['m_signpurpose'] == "L") {
         else {
          //$maximum = $is_ck['i_maximum'];
          if ($cate_label=='부동산') {
              $maximum = "10000000";
              if( $progress['total'] >= 20000000){
                $avail = 0;
              }else{
                $avail = $progress['budongsan'] >= 10000000 ? 0 : 10000000 - $progress['budongsan'];
                $avail = (20000000 - $progress['total'] ) < $avail ? (20000000 - $progress['total'] ) : $avail;
              }
          }else {
            $maximum = "20000000";
            $avail = $progress['total'] >= 20000000 ? 0 : 20000000 - $progress['total'];
          }
          $member_level_label = ($user['m_signpurpose'] == "L")?'대출회원':'일반개인투자자';
          $i_profit=$is_ck['i_profit'];//개인투자자
          $i_withholding=$is_ck['i_withholding_personal'];//개인투자자
          $i_withholding_v=$is_ck['i_withholding_personal_v'];//개인투자자
          //$is_ck['i_maximum']
         }
     }
     if( $avail == -1 ){
       $avail = $maximum - $progress['total'];
     }
     //총한도, 라벨링, 수수료율,
     return array('insetpay'=>$maximum, 'invest_flag'=>$member_level_label,'i_profit'=>$i_profit,'i_withholding'=>$i_withholding,'i_withholding_v'=>$i_withholding_v , 'avail'=>$avail,"progress"=>$progress,"cate_label"=>$cate_label );
  }
  function getMemberlimit ($mem){
    if ( is_array($mem) && isset( $mem['m_level'] ) && isset( $mem['m_signpurpose'] ) ) $user = $mem;
    else {
      $sql = "select * from mari_member where m_id ='".$mem."'";
      $user = sql_fetch($sql, false);
    }
    $sql = "select  * from  mari_inset";
    $is_ck = sql_fetch($sql, false);

    if($user['m_level'] >= "3" ) {
      $maximum = $is_ck['i_maximum_v'];
      $maximum2 =$maximum;
      $per_limit = 5000000000;
      $member_level_label ='법인투자자';
      if( $user['m_signpurpose']=='L'){
        $per_limit = $maximum2 =$maximum = 0;
        $member_level_label ='법인대출회원';
      }
      $i_profit=$is_ck['i_profit_v'];//소득적격투자자
      $i_withholding=$is_ck['i_withholding_burr'];//소득적격투자자
      $i_withholding_v=$is_ck['i_withholding_burr_v'];//소득적격투자자
      //$is_ck['i_maximum_v']
    } //else if ($user['m_level'] == "2") {
      else {
         if ($user['m_signpurpose'] == "I") {
           $maximum = $is_ck['i_maximum_in'];
           $maximum2 =$maximum;
           $per_limit = 20000000;
           $member_level_label = '소득적격투자자';
           $i_profit=$is_ck['i_profit_in'];//소득적격투자자
           $i_withholding=$is_ck['i_withholding_in'];//소득적격투자자
           $i_withholding_v=$is_ck['i_withholding_in_v'];//소득적격투자자
           //$is_ck['i_maximum_in']
         } else if ($user['m_signpurpose'] == "P") {
           $maximum = $is_ck['i_maximum_pro'];
           $maximum2 =$maximum;
           $per_limit = 5000000000;
           $member_level_label = '전문투자자';
           $i_profit=$is_ck['i_profit_pro'];//전문투자자
           $i_withholding=$is_ck['i_withholding_pro'];//전문투자자
           $i_withholding_v=$is_ck['i_withholding_pro_v'];//전문투자자
           //$is_ck['i_maximum_pro']
         } else if ($user['m_signpurpose'] == "L2") {
           $maximum = $is_ck['i_maximum_personalloan'];
           $maximum2 =$maximum;
           $per_limit = 5000000;
           $member_level_label ='개인대부사업자투자자';
           $i_profit=$is_ck['i_profit_personalloan'];//개인대부사업자투자자
           $i_withholding=$is_ck['i_withholding_personalloan'];//개인대부사업자투자자
           $i_withholding_v=$is_ck['i_withholding_personalloan_v'];//개인대부사업자투자자
           //$is_ck['i_maximum_personalloan']
         } else if ($user['m_signpurpose'] == "C2") {
           $maximum = $is_ck['i_maximum_corporateloan'];
           $maximum2 =$maximum;
           $per_limit = 5000000000;
           $member_level_label ='법인대부사업자투자자';
           $i_profit=$is_ck['i_profit_corporateloan'];//법인대부사업자투자자
           $i_withholding=$is_ck['i_withholding_corporateloan'];//법인대부사업자투자자
           $i_withholding_v=$is_ck['i_withholding_corporateloan_v'];//법인대부사업자투자자
           //$is_ck['i_maximum_corporateloan']
         } else if ($user['m_signpurpose'] == "I2") {
           $maximum = $is_ck['i_maximum_incomeloan'];
           $maximum2 =$maximum;
           $per_limit = 20000000;
           $member_level_label ='소득적격대부업자투자자';
           $i_profit=$is_ck['i_profit_incomeloan'];//소득적격대부투자자
           $i_withholding=$is_ck['i_withholding_incomeloan'];//소득적격대부투자자
           $i_withholding_v=$is_ck['i_withholding_incomeloan_v'];//소득적격대부투자자
           //$is_ck['i_maximum_incomeloan']
         }
         //if ($user['m_signpurpose'] == "N" || $user['m_signpurpose'] == "L") {
         else {
          $maximum = $is_ck['i_maximum'];
          $maximum2 =10000000;//부동산
          $per_limit = 5000000;//
          $member_level_label = ($user['m_signpurpose'] == "L")?'대출회원':'일반개인투자자';
          $i_profit=$is_ck['i_profit'];//개인투자자
          $i_withholding=$is_ck['i_withholding_personal'];//개인투자자
          $i_withholding_v=$is_ck['i_withholding_personal_v'];//개인투자자
          //$is_ck['i_maximum']
         }
     }
     //총한도, 라벨링, 수수료율,
     return array('insetpay'=>$maximum,'insetpay2'=>$maximum2,'per_limit'=>$per_limit, 'invest_flag'=>$member_level_label,'i_profit'=>$i_profit,'i_withholding'=>$i_withholding,'i_withholding_v'=>$i_withholding_v );
  }

  function getMemberlimitInvest( $mem, $loanid ) {
    if ( is_array($mem) && isset( $mem['m_level'] ) && isset( $mem['m_signpurpose'] ) ) $user = $mem;
    else {
      $sql = "select * from mari_member where m_id ='".$mem."'";
      $user = sql_fetch($sql, false);
    }
    //채권당 한도
    $sql    = "select  * from  mari_invest_progress where loan_id='$loanid'";
    $iv_pay = sql_fetch($sql, false);

    /* 누적금액 등 필요시
    $sql             = "select  * from  mari_inset";
    $is_ck           = sql_fetch($sql, false);
    */

    //level 1 이 정의 되어 있지 않아서 if 문 변경 함
    if($user['m_level'] >= "3" ) {
     $per_maximum = $iv_pay['i_maximum_v'];
     $member_level_label ='법인회원투자자';
     //$is_ck['i_maximum_v']
   } //else if ($user['m_level'] == "2") {
     else {
        if ($user['m_signpurpose'] == "N" || $user['m_signpurpose'] == "L") {
          $per_maximum = $iv_pay['i_maximum'];
          $member_level_label = '일반개인투자자';
          //$is_ck['i_maximum']
        }else if ($user['m_signpurpose'] == "I") {
          $per_maximum = $iv_pay['i_maximum_in'];
          $member_level_label = '소득적격투자자';
          //$is_ck['i_maximum_in']
        } else if ($user['m_signpurpose'] == "P") {
          $per_maximum = $iv_pay['i_maximum_pro'];
          $member_level_label = '전문투자자';
          //$is_ck['i_maximum_pro']
        } else if ($user['m_signpurpose'] == "L2") {
          $per_maximum = $iv_pay['i_maximum_personalloan'];
          $member_level_label ='개인대부사업자투자자';
          //$is_ck['i_maximum_personalloan']
        } else if ($user['m_signpurpose'] == "C2") {
          $per_maximum = $iv_pay['i_maximum_corporateloan'];
          $member_level_label ='법인대부사업자투자자';
          //$is_ck['i_maximum_corporateloan']
        } else if ($user['m_signpurpose'] == "I2") {
          $per_maximum = $iv_pay['i_maximum_incomeloan'];
          $member_level_label ='소득적격대부업자투자자';
          //$is_ck['i_maximum_incomeloan']
        }
    }
    return array('per_maximum'=>$per_maximum, 'member_level_label'=>$member_level_label);
  }
?>
