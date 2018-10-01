<?php
if (!defined('_MARICMS_')) exit;
header('Content-Type: text/html; charset=utf-8');
@extract($_GET);
@extract($_POST);
@extract($_SERVER);
$timetoday = mktime();
$date = date("Y-m-d H:i:s", $timetoday);
$ip=$_SERVER['REMOTE_ADDR'];
/*상점서비스정보*/
$sql = " select  * from mari_mysevice_config";
$mysv = sql_fetch($sql, false);

/*관리자 서버접속 start*/
include_once(MARI_SQL_PATH.'/master_connect.php');

/*마스터 해당 서비스정보*/
$sql = " select  * from mari_mysevice_mainconfig where sale_code='kfunding'";
$master = sql_fetch($sql, false);

$mysv[sale_code]="kfunding";
/************************************************
imwork
************************************************/

	if($cms=="cs_bbs_list"){


		/*게시판 환경설정*/
		$sql = " select  * from  mari_board where bo_table='$table'";
		$bbs_config = sql_fetch($sql, false);

		/*서비스이용중이고 그룹아이디가 잘못되었을경우 리다이렉트 2017-10-13 추가*/
		/*테스트 끝나면사용
		if($master['imwork_use']=="Y" && $gr_id=="project" && $skin=="client_main"){
			goto_url(MARI_HOME_URL.'/?cms=cs_bbs_list&gr_id=productInquiry&table=modified&subject=클라이언트메인&skin=client_main');
		}
		*/


	/*고객지원인경우 변경*/
	if($gr_id=="productInquiry"){

		/*문의현황 상태에 따른 수정 시작- 171012 전인성*/
		if($status){
			$sql_common = " from mari_write ";
			$tablesort="A LEFT JOIN mari_board B ON A.w_table=B.bo_table where A.m_id='".$mysv[sale_code]."' and B.gr_id='productInquiry' and A.w_projectstatus='".$status."'";

		}else{

			$sql_common = " from mari_write ";
			$tablesort="A LEFT JOIN mari_board B ON A.w_table=B.bo_table where A.m_id='".$mysv[sale_code]."' and B.gr_id='productInquiry'";

		}
		/*문의현황 상태에 따른 수정 끝- 171012 전인성*/

		if (!$sst) {
			$sst = $bbs_config['bo_sort_field'];

		}
	//	$sql_order = "group by A.w_id order by $sst $sod ";
		$sql_order = " order by $sst $sod ";

	}else{
		if($all=="Y"){
			$sql_common = " from mari_write A LEFT JOIN mari_board B ON A.w_table=B.bo_table where A.m_id='".$mysv[sale_code]."' and B.gr_id='$gr_id'";

			if ($stx) {

			$sql_search = " where (1) ";

				$sql_search .= " and ( ";

						$sql_search .= " ($sfl like '$stx%') ";

				$sql_search .= " ) ";
			}

		}else{
			$sql_common = " from mari_write ";

			$sql_search = " where (1) ";
			if ($stx) {
				$sql_search .= " and ( ";

						$sql_search .= " ($sfl like '$stx%') ";

				$sql_search .= " ) ";
			}

			$tablesort="and (w_table='$table') and m_id = '".$mysv[sale_code]."'";
		}

		/*검색 추가 시작(확인필요) - 171011 전인성*/
		if($table=='modified'){

//			if($_GET[w_company_name]){
//				$sql_search .= " and ( ";
//				$sql_search .= "w_company_name like '%$w_company_name%'";
//				$sql_search .= " ) ";
//			}

			if($_GET[w_subject]){
				$sql_search .= " and ( ";
				$sql_search .= "w_subject like '%$w_subject%'";
				$sql_search .= " ) ";
			}

//			if($_GET[modifiedstaut]){
//				if($modifiedstaut == 'all'){
//					$sql_search .= " and (1=1)";
//				}else{
//					$status = "w_projectstatus = '$modifiedstaut'";
//					$sql_search .= " and ( ";
//					$sql_search .= "".$status."";
//					$sql_search .= " ) ";
//				}
//			}

//			if($_GET[staff_name]){
//				$sql = "select distinct(w_id) from mari_comment where w_table='$table' and staff_name like '%$staff_name%'";
//				$result = sql_query($sql);
//
//				$sql2 = "select count(*) as cnt from mari_comment where w_table='$table' and staff_name like '%$staff_name%'";
//				$result_cnt = sql_fetch($sql2);
//
//				if($result_cnt['cnt']>0){
//					$sql_search .= " and ( ";
//					for($i=0; $row=sql_fetch_array($result); $i++){
//						$sql_search .= " w_id = '".$row['w_id']."'";
//						$sql_search .= " or";
//					}
//					$sql_search = substr($sql_search,0,-2);
//					$sql_search .= " ) ";
//				}else{
//					$sql_search .= "and ( w_id = 'null')";
//				}
//			}

			if($_GET[datepro]){
				if($search_date=="접수일"){
					$sql_search .= " and ( ";
					$sql_search .= " w_datetime like '$datepro%' ";
					$sql_search .= " ) ";
				}else if($search_date=="처리예정일"){
					$sql_search .= "and ( ";
					$sql_search .= " datepro like '$datepro%' ";
					$sql_search .= " ) ";
//					$sql = "select distinct(w_id) from mari_comment where w_table='$table' and datepro like '$datepro%'";
//					$result = sql_query($sql);
//
//					$sql2 = "select count(*) as cnt from mari_comment where w_table='$table' and datepro like '$datepro%'";
//					$result_cnt = sql_fetch($sql2);
//
//					if($result_cnt['cnt']>0){
//						$sql_search .= " and ( ";
//						for($i=0; $row=sql_fetch_array($result); $i++){
//							$sql_search .= " w_id = '".$row['w_id']."'";
//							$sql_search .= " or";
//						}
//						$sql_search = substr($sql_search,0,-2);
//						$sql_search .= " ) ";
//					}else{
//						$sql_search .= "and ( w_id = 'null')";
//					}
				}
			}

			if($_GET[modifiedstaut]){
				if($modifiedstaut == 'all'){
					$sql_search .= " and (1=1)";
				}else{
					$status = "w_projectstatus = '$modifiedstaut'";
					$sql_search .= " and ( ";
					$sql_search .= "".$status."";
					$sql_search .= " ) ";
				}
			}

//			if($_GET[w_catecode]){
//				if($w_catecode=='전체'){
//					$sql_search .= " and (1=1)";
//				}else{
//					$sql_search .= " and ( ";
//					$sql_search .= " w_catecode = '$w_catecode' ";
//					$sql_search .= " ) ";
//				}
//			}
		}
		/*검색 추가 끝(확인필요)*/

		if (!$sst) {
			$sst = $bbs_config['bo_sort_field'];

		}

		$sql_order = " order by $sst $sod ";
	}



		$sql = " select count(*) as cnt $sql_common $sql_search  ".$tablesort." $sql_order ";
		$row = sql_fetch($sql);
		$total_count = $row['cnt'];

		/*게시판환경설정에 설정값이있는경우 환경설정대신 게시판환경설정값을 불러오도록*/
		if(!$bbs_config['bo_page_rows']){
			$rows = $config['c_page_rows'];
		}else{
			$rows = $bbs_config['bo_page_rows'];
		}
		$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
		if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
		$from_record = ($page - 1) * $rows; // 시작 열을 구함

		$sql = " select * $sql_common $sql_search ".$tablesort." $sql_order limit $from_record, $rows ";
		$result = sql_query($sql);

		$colspan = 16;

		$sql="select * from mari_board_group order by gr_id asc";
		$group_list=sql_query($sql, false);

		/*현재상태값 저장 2017-09-18 추가*/
		/*뎃글수*/
		$sql = " select count(*) as cnt from mari_comment where w_id='$id'";
		$cocnt = sql_fetch($sql);
		$cotop= $cocnt['cnt'];
		/*가장최근 뎃글의 완료여부가져옴*/
		$sql = " select * from mari_comment order by co_datetime desc";
		$useck = sql_fetch($sql);
		/*고객센터의 경우*/
		if($gr_id=="productInquiry" || $imwork_use=="Y"){
			$sql = " select count(*) as cnt from mari_write A LEFT JOIN
			mari_board B ON A.w_table=B.bo_table where A.m_id='".$mysv[sale_code]."' and A.w_projectstatus='W' and B.gr_id='productInquiry'
			";
			$cocnt = sql_fetch($sql);
			$status_W= $cocnt['cnt'];
			/*진행중*/
			$sql = " select count(*) as cnt from mari_write A LEFT JOIN
			mari_board B ON A.w_table=B.bo_table where A.m_id='".$mysv[sale_code]."' and  A.w_projectstatus='P' and B.gr_id='productInquiry'
			";
			$cocnt = sql_fetch($sql);
			$status_P= $cocnt['cnt'];
			/*완료*/
			$sql = " select count(*) as cnt from mari_write A LEFT JOIN
			mari_board B ON A.w_table=B.bo_table  where A.m_id='".$mysv[sale_code]."' and A.w_projectstatus='C' and B.gr_id='productInquiry'
			";
			$cocnt = sql_fetch($sql);
			$status_C= $cocnt['cnt'];
			/*완료*/
			$sql = " select count(*) as cnt from mari_write A LEFT JOIN
			mari_board B ON A.w_table=B.bo_table  where A.m_id='".$mysv[sale_code]."' and A.w_projectstatus='R' and B.gr_id='productInquiry'
			";
			$cocnt = sql_fetch($sql);
			$status_R= $cocnt['cnt'];

		}else{

			/*접수*/
			$sql = " select count(*) as cnt from mari_write where w_table='$table' and w_projectstatus='W' and m_id='".$mysv[sale_code]."'";
			$cocnt = sql_fetch($sql);
			$status_W= $cocnt['cnt'];
			/*진행중*/
			$sql = " select count(*) as cnt from mari_write where w_table='$table' and w_projectstatus='P' and m_id='".$mysv[sale_code]."'";
			$cocnt = sql_fetch($sql);
			$status_P= $cocnt['cnt'];
			/*완료*/
			$sql = " select count(*) as cnt from mari_write where w_table='$table' and w_projectstatus='C' and m_id='".$mysv[sale_code]."'";
			$cocnt = sql_fetch($sql);
			$status_C= $cocnt['cnt'];
			/*완료*/
			$sql = " select count(*) as cnt from mari_write where w_table='$table' and w_projectstatus='R' and m_id='".$mysv[sale_code]."'";
			$cocnt = sql_fetch($sql);
			$status_R= $cocnt['cnt'];
		}

			/*프로젝트 단계별 진행현황*/
			$sql = " select * from mari_write where w_table='projectstatus' and m_id='".$mysv[sale_code]."' order by w_datetime desc";
			$prodata = sql_fetch($sql);

		/*진행현황 % 수정*/
		$sum_pct = $prodata['w_design_pct'] + $prodata['w_publishing_pct'] + $prodata['w_develop_pct'];
		if($sum_pct > 0){
			$newprogress = floor($sum_pct/3);
		}else{
			$newprogress = 0;
		}

//		/*진행현황 %*/
//		$cdate = $prodata[w_project_complete]; //완료일
//		$sdate = $prodata[w_design_schedule]; //시작일
//		$todday = date("Y-m-d", time());  //오늘날짜
//		/*시작일부터 완료일까지의 일수*/
//		$playday_top = ( strtotime($cdate) - strtotime($sdate) ) / 86400;
//
//		/*현재까지의 일수*/
//		$playday_today = ( strtotime($cdate) - strtotime($todday) ) / 86400;
//		/*남은일수=시작일부터 완료일까지의 일수 - 현재까지의 일수*/
//		$playday_today=$playday_top-$playday_today;
//		/*백분율 %수치*/
//		if($playday_today>0){
//		/* 남은일수 / 시작일부터 완료일까지의 일수 * 100 */
//			$newprogress=floor($playday_today/$playday_top*100);
//		}else{
//			$newprogress="0";
//		}

		$startdate=date("m-d", strtotime($sdate));
		$enddate=date("m-d", strtotime($cdate));

/************************************************
admin 게시판 상세(공통)
************************************************/

	}else if($cms=="cs_bbs_view"){

		/*게시판 환경설정*/
		$sql = " select  * from  mari_board where bo_table='$table'";
		$bbs_config = sql_fetch($sql, false);
		if($bbs_config['bo_read_level']=="1"){
		}else{
			if($bbs_config['bo_read_level']>$user['m_level']){
				alert('글읽기 권한이 없습니다.');
				exit;
			}
		}

		if($type=="view"){

			/*조회수증가 COOKIE담기
			if ($_COOKIE['ck_id'] != $id)
			{
				$sql = " update mari_write set w_hit = w_hit + 1 where w_table='$table' and w_id='$id'";
				sql_query($sql);
				// 하루 동안만
				set_cookie("ck_id", $id, 60*60*24);
			}
			*/
		$sql = " select  * from  mari_write  where w_table='$table' and w_id='$id' and m_id='".$mysv[sale_code]."'";
		$w = sql_fetch($sql, false);


		/*휴대폰번호 분리*/
		$w_hp = $bo['w_hp'];
		$hp1=substr($w_hp,0,3);
		$hp2=substr($w_hp,3,-4);
		$hp3=substr($w_hp,-4);
		}else{
			alert('정상적인 접근이 아닙니다.');
		}
		/*첨부파일*/
		$dw_file = MARI_DATA_URL."/$table/".$w[file_img]."";

		/*댓글*/
		$sql = " select * from mari_comment where w_id='$id' and w_table='$table'";
		$ment = sql_query($sql);

		/*수정할 댓글*/
		$sql = "select * from mari_comment where co_id = '$co_id' and w_id = '$id' and w_table = '$table'";
		$ment_modi = sql_fetch($sql);


		/*현재상태값 저장 2017-09-18 추가*/
		/*뎃글수*/
		$sql = " select count(*) as cnt from mari_comment where w_id='$id'";
		$cocnt = sql_fetch($sql);
		$cotop= $cocnt['cnt'];
		/*가장최근 뎃글의 완료여부가져옴*/
		$sql = " select * from mari_comment where w_id='$id' order by co_datetime desc";
		$useck = sql_fetch($sql);

		/*접수*/
		$sql = " select count(*) as cnt from mari_write where w_table='$table' and w_projectstatus='W' and m_id='".$mysv[sale_code]."'";
		$cocnt = sql_fetch($sql);
		$status_W= $cocnt['cnt'];
		/*진행중*/
		$sql = " select count(*) as cnt from mari_write where w_table='$table' and w_projectstatus='P' and m_id='".$mysv[sale_code]."'";
		$cocnt = sql_fetch($sql);
		$status_P= $cocnt['cnt'];
		/*완료*/
		$sql = " select count(*) as cnt from mari_write where w_table='$table' and w_projectstatus='C' and m_id='".$mysv[sale_code]."'";
		$cocnt = sql_fetch($sql);
		$status_C= $cocnt['cnt'];
		/*완료*/
		$sql = " select count(*) as cnt from mari_write where w_table='$table' and w_projectstatus='R' and m_id='".$mysv[sale_code]."'";
		$cocnt = sql_fetch($sql);
		$status_R= $cocnt['cnt'];


			/*IE버전 DISPLAY NONE 예외처리 2017-10-16추가*/
			$userAgent = $_SERVER["HTTP_USER_AGENT"];
			if ( preg_match("/MSIE 6.0[0-9]*/", $userAgent) ) {
			}elseif ( preg_match("/MSIE 7.0*/", $userAgent) ) {
			}elseif ( preg_match("/MSIE 8.0*/", $userAgent) ) {
			}elseif ( preg_match("/MSIE 9.0*/", $userAgent) ) {
			}elseif ( preg_match("/MSIE 10.0*/", $userAgent) ) {
			}elseif ( preg_match("/rv:11.0*/", $userAgent) ) {
			}else{
				$rebt="<a class=\"btn_holdin\" href=\"javascript:;\">다시 문의하기</a>";
				$display = "display:none;";
			}




/************************************************
admin 게시판 쓰기(공통)
************************************************/

	}else if($cms=="cs_bbs_write"){



		/*게시판 환경설정*/
		$sql = " select  * from  mari_board where bo_table='$table'";
		$bbs_config = sql_fetch($sql, false);
		if($bbs_config['bo_read_level']=="1"){
		}else{
			if($bbs_config['bo_write_level']>$user['m_level']){
				alert('글쓰기 권한이 없습니다.');
				exit;
			}

			if($bbs_config['bo_reply_level']>$user['m_level']){
				alert('글답변 권한이 없습니다.');
				exit;
			}
		}

		if($type=="m"){

		$sql = " select  * from  mari_write  where w_table='$table' and w_id='$id' and m_id='".$mysv[sale_code]."'";
		$w = sql_fetch($sql, false);

		if(!$member_ck){
				/*휴대폰번호 분리*/
				$w_hp = $w['w_hp'];
				$hp1=substr($w_hp,0,3);
				$hp2=substr($w_hp,3,-4);
				$hp3=substr($w_hp,-4);
		}else{
				/*휴대폰번호 분리*/
				$w_hp = $w['w_hp'];
				$hp1=substr($w_hp,0,3);
				$hp2=substr($w_hp,3,-4);
				$hp3=substr($w_hp,-4);
		}
		}else if($type=="w"){
		}else if($type=="w_project"){
			$sql = "select count(*) as cnt from mari_write where w_table='".$table."' and w_id='3' and m_id='".$mysv[sale_code]."'" ;
			$proj_list_cnt = sql_fetch($sql);
			$proj_cnt = $proj_list_cnt['cnt'];

			$sql = "select * from  mari_write where w_table='".$table."' and w_id='3' and m_id='".$mysv[sale_code]."'";
			$proj_list = sql_fetch($sql, false);
		}else{
			alert('정상적인 접근이 아닙니다.');
		}




/************************************************
admin 코멘트 쓰기(공통)
************************************************/


	}else if($cms=="cs_bbs_comment"){

		/*게시판 환경설정*/
		$sql = " select  * from  mari_board where bo_table='$table'";
		$bbs_config = sql_fetch($sql, false);
		if($bbs_config['bo_read_level']=="1"){
		}else{
			if($bbs_config['bo_comment_level']>$user['m_level']){
				alert('코멘트쓰기 권한이 없습니다.');
				exit;
			}
		}



	}
?>