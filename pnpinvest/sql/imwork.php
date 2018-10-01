<?php
include_once('../../mari_path.php'); // 기본설정파일
include_once('../config.php');   // config 파일
include_once('../../core/core.php');   // 설정 파일

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
댓글수정관리
************************************************/
	if($update=="cs_bbs_comment"){
		
			if($type=="w"){
				$sql = "insert into mari_comment
						set w_table = '$table',
						w_id = '$w_id',
						m_id = '$mysv[sale_code]',
						co_name = '$m_name',
						co_level = '$user[m_level]',
						co_content = '$co_content',
						business_cate = '$business_cate',
						staff_id = '$staff_id',
						staff_name = '$staff_name',
						clear_use = '$clear_use',
						co_memo = '$co_memo',
						datepro = '$datepro',
						co_datetime = '$date'	,
						co_ip = '$ip'
						";
				sql_query($sql);
				alert('댓글을 등록하였습니다.');
			}else if($type=="m"){
				$sql = "update mari_comment
						set co_content = '$co_content',
						business_cate = '$business_cate',
						staff_id = '$staff_id',
						staff_name = '$staff_name',
						clear_use = '$clear_use',
						co_memo = '$co_memo',
						datepro = '$datepro',
						co_last = '$date'
						where co_id = '$co_id' and w_id = '$w_id' and w_table = '$table'
						";
				sql_query($sql);
				alert('댓글을 수정하였습니다.',''.MARI_HOME_URL.'/?cms=cs_bbs_view&type=view&table='.$table.'&id='.$id.'');
			}else if($type=="d"){
				$sql = "delete from mari_comment where co_id = '$co_id' and w_id = '$w_id'";
				sql_query($sql);
				alert('댓글을 삭제하였습니다.');
			}

		

/************************************************
댓글수정관리
************************************************/

	}else if($update=="bbs_comment"){

			if($type=="w"){
				$sql = "insert into mari_comment
						set w_table = '$table',
						w_id = '$w_id',
						m_id = '$mysv[sale_code]',
						co_name = '$m_name',
						co_level = '$user[m_level]',
						co_content = '$co_content',
						business_cate = '$business_cate',
						staff_id = '$staff_id',
						staff_name = '$staff_name',
						clear_use = '$clear_use',
						contact_us = 'Y',
						co_memo = '$co_memo',
						co_datetime = '$date'	,
						co_ip = '$ip'
						";
				sql_query($sql);
				/*현재상태 변경 작성글중 가장최신것, 수정일을 현재시간으로 update*/
				if($w_projectstatus){
					$sql = "update mari_write 
							set w_projectstatus = '$w_projectstatus',
							w_last = '$date' 
							where w_id = '$w_id' and w_table = '$table' and m_id='".$mysv[sale_code]."' order by w_datetime desc
							";
					sql_query($sql);
				}


				alert('정상적으로 접수 하였습니다.');
			}else if($type=="m"){
				$sql = "update mari_comment
						set co_content = '$co_content',
						business_cate = '$business_cate',
						staff_id = '$staff_id',
						staff_name = '$staff_name',
						clear_use = '$clear_use',
						co_memo = '$co_memo',
						datepro = '$datepro',
						co_last = '$date'
						where co_id = '$co_id' and w_id = '$w_id' and w_table = '$table'
						";
				sql_query($sql);
				alert('댓글을 수정하였습니다.',''.MARI_HOME_URL.'/?cms=cs_bbs_view&type=view&table='.$table.'&id='.$id.'');
			}else if($type=="d"){
				$sql = "delete from mari_comment where co_id = '$co_id' and w_id = '$w_id'";
				sql_query($sql);
				alert('댓글을 삭제하였습니다.');
			}



/************************************************
사용자 게시판 쓰기(공통)
************************************************/

	}else if($update=="cs_bbs_write"){

		/*게시판 환경설정*/
		$sql = " select  * from  mari_board where bo_table='$table'";
		$bbs_config = sql_fetch($sql, false);

//		if($bbs_config['bo_write_level']>$user['m_level']){
//			alert('글쓰기 권한이 없습니다.');
//			exit;
//		}

		$timetoday = mktime();
		$now = date("Y-m-d H:i:s", $timetoday);
		/*디렉톡리생성*/
		@mkdir(MARI_DATA_PATH."/$table", MARI_DIR_PERMISSION);
		@chmod(MARI_DATA_PATH."/$table", MARI_DIR_PERMISSION);

		$tmp_file  = $_FILES['u_img']['tmp_name'];
		$filesize  = $_FILES['u_img']['size'];
		$file_img=$_FILES['u_img']['name'];
		$file_img  = preg_replace('/(<|>|=)/', '', $file_img);


		if (is_uploaded_file($tmp_file)) {
			/*설정한 업로드 사이즈보다 크다면 건너뛰도록*/
			if (!$filesize > $bbs_config['bo_upload_size']) {
				$file_upload_msg .= '\"'.$file_img.'\" 파일의 용량('.number_format($filesize).' 바이트)이 게시판에 설정('.number_format($bbs_config['bo_upload_size']).' 바이트)된 값보다 크기때문에 업로드가 불가능합니다.\\n';
				continue;
			}

			/*이미지나 플래시 파일에 악성코드를 심어 업로드 하는 경우를 방지하기위함
			 에러메세지는 출력하지 않도록.*/
			//-----------------------------------------------------------------
			$timg = @getimagesize($tmp_file);
			// image type
			if ( preg_match("/\.(".$config['c_image_upload'].")$/i", $file_img) ||
				 preg_match("/\.(".$config['c_flash_upload'].")$/i", $file_img) ) {
				if ($timg['2'] < 1 || $timg['2'] > 16)
					continue;
			}

		}

		/*파일업로드*/
		if(!$file_img==""){
			$img_update="file_img	 = '".$file_img."',";
			if ($_FILES['u_img']['name']) upload_file($_FILES['u_img']['tmp_name'], $file_img, MARI_DATA_PATH."/$table");
		}
		
		/*휴대폰번호 합침*/
		if(!$w_hp){
			$w_hp="".$hp1."".$hp2."".$hp3."";
		}

		/*페스워드가 있을경우에만*/

			$pw_yes="w_password = '".md5($w_password)."',";


				/*중복체크 최고관리자또는 게시판관리자인경우에는 중복체크하지않음*/
		if($master[sale_code]==$mysv[sale_code] || $master[sale_code]==$bbs_config[bo_admin]){
		}else{
			if ($mysv[sale_code]=="admin" || $mysv[sale_code]=="ADMIN"  || $mysv[sale_code]=="adm" )
				alert('사용하실 수 없는 아이디 입니다.\\n 다른 아이디를 이용하여 주십시오.');

			if ($w_name=="최고관리자" || $w_name=="관리자"  || $w_name=="운영자" )
				alert('사용하실 수 없는 이름 입니다.\\n 다른 이름을 이용하여 주십시오.');
		}

		if($type=="w"){

			/*insert*/
				$sql = " insert into mari_write 
							set w_table = '$table', 
							".$pw_yes."
							w_num = '$w_num',
							m_id = '$mysv[sale_code]',
							w_reply = '$w_reply',
							w_catecode = '$w_catecode',
							w_comment = '$w_comment',
							w_subject = '$w_subject',
							w_content = '$w_content',
							w_hit = '$w_hit',
							w_id = '$w_id',
							w_name = '$w_name',
							w_company_name = '$w_company_name',
							w_email = '$w_email',
							w_hp = '$w_hp',
							w_ip = '$ip',
							w_count_file = '$w_count_file',
							w_count_image = '$w_count_image',
							w_notice = '$w_notice',						
							w_main_exposure = '$w_main_exposure',	
							w_rink	 = '$w_rink',
							w_open_date	 = '$w_open_date',
							".$img_update."
							w_blank = '$w_blank',
							w_person = '$w_person',
							w_datetime ='$date',
							w_url_path = '$w_url_path'";
					sql_query($sql);

				alert('정상적으로 작성 하였습니다.',''.MARI_HOME_URL.'/?cms=cs_bbs_list&gr_id='.$gr_id.'&table='.$table.'&type='.$type.'&skin='.$skin.'');


		}else if($type=="w_project"){/*신규프로젝트*/

			$tmp_g_option = array();
			if(count($w_design_manager) > 0){
				for($i=0; $i<count($w_design_manager); $i++){
					if($w_design_manager[$i] != ""){
						$w_design_manager[$i] = (string)$w_design_manager[$i];
						$w_design_manager[$i] = preg_replace("/[^0-9]/", "",$w_design_manager[$i]);
						$w_design_manager[$i] = $w_design_manager[$i];

						if($i==count($w_design_manager)-1){
							$tmp_option = "".$w_design_manager[$i]."";
						}else{
							$tmp_option = "".$w_design_manager[$i]."[FIELD]"."";
						}
						
					}
					$tmp_g_option[] = $tmp_option;
				}
//				$w_design_manager_list = implode("[RECORD]",$tmp_g_option);
				$w_design_manager_list = $tmp_g_option;
			}else{
				$w_design_manager_list = '';
			}

			$tmp_g_option2 = array();
			if(count($w_puglishing_manager) > 0){
				for($i=0; $i<count($w_puglishing_manager); $i++){
					if($w_puglishing_manager[$i] != ""){
						$w_puglishing_manager[$i] = (string)$w_puglishing_manager[$i];
						$w_puglishing_manager[$i] = preg_replace("/[^0-9]/", "",$w_puglishing_manager[$i]);
						$w_puglishing_manager[$i] = $w_puglishing_manager[$i];

						if($i==count($w_puglishing_manager)-1){
							$tmp_option = "".$w_puglishing_manager[$i]."";
						}else{
							$tmp_option = "".$w_puglishing_manager[$i]."[FIELD]"."";
						}
					}
					$tmp_g_option2[] = $tmp_option;
				}
				//$w_publishing_manager_list = implode("[RECORD]",$tmp_g_option);
				$w_publishing_manager_list = $tmp_g_option2;
			}else{
				$w_publishing_manager_list = '';
			}

			$tmp_g_option3 = array();
			if(count($w_develop_manager) > 0){
				for($i=0; $i<count($w_develop_manager); $i++){
					if($w_develop_manager[$i] != ""){
						$w_develop_manager[$i] = (string)$w_develop_manager[$i];
						$w_develop_manager[$i] = preg_replace("/[^0-9]/", "",$w_develop_manager[$i]);
						$w_develop_manager[$i] = $w_develop_manager[$i];

						if($i==count($w_develop_manager)-1){
							$tmp_option = "".$w_develop_manager[$i]."";
						}else{
							$tmp_option = "".$w_develop_manager[$i]."[FIELD]"."";
						}
					}
					$tmp_g_option3[] = $tmp_option;
				}
				//$w_develop_manager_list = implode("[RECORD]",$tmp_g_option);
				$w_develop_manager_list = $tmp_g_option3;
			}else{
				$w_develop_manager_list = '';
			}

			$tmp_g_option4 = array();
			if(count($w_inspection_manager) > 0){
				for($i=0; $i<count($w_inspection_manager); $i++){
					if($w_inspection_manager[$i] != ""){
						$w_inspection_manager[$i] = (string)$w_inspection_manager[$i];
						$w_inspection_manager[$i] = preg_replace("/[^0-9]/", "",$w_inspection_manager[$i]);
						$w_inspection_manager[$i] = $w_inspection_manager[$i];

						if($i==count($w_inspection_manager)-1){
							$tmp_option = "".$w_inspection_manager[$i]."";
						}else{
							$tmp_option = "".$w_inspection_manager[$i]."[FIELD]"."";
						}
					}
					$tmp_g_option4[] = $tmp_option;
				}
//				$w_inspection_manager_list = implode("[RECORD]",$tmp_g_option);
				$w_inspection_manager_list = $tmp_g_option4;
			}else{
				$w_inspection_manager_list = '';
			}

			/*insert*/
				$sql = "insert into mari_write
						set w_table = '$table',
						w_catecode = '$subject',
						m_id = '$mysv[sale_code]',
						w_company_name = '$w_company_name',
						w_company_manager = '$w_company_manager',
						w_hp = '$w_hp',
						w_company_email= '$w_company_email',
						w_project_name = '$w_project_name',
						w_design_pct = '$w_design_pct',
						w_design_chk = '$w_design_pct',
						w_publishing_pct = '$w_publishing_pct',
						w_publishing_chk = '$w_publishing_chk',
						w_develop_pct = '$w_develop_pct',
						w_develop_chk= '$w_develop_chk',
						w_projectstatus	= '$w_projectstatus',
						w_project_complete = '$w_project_complete',
						w_design_manager = '$w_design_manager_list',
						w_publishing_manager = '$w_publishing_manager_list',
						w_develop_manager = '$w_develop_manager_list',
						w_inspection_manager = '$w_inspection_manager_list',
						file_img = '$file_name'";
					sql_query($sql);
					alert('정상적으로 작성 하였습니다.',''.MARI_HOME_URL.'/?cms=cs_bbs_list&gr_id='.$gr_id.'&type='.$type.'&table='.$table.'&skin='.$skin.'');
				
		}else if($type=="customer"){/*긴급접수*/

			/*insert*/
				$sql = " insert into mari_write 
							set w_table = '$table', 
							".$pw_yes."
							w_num = '$w_num',
							m_id = '$mysv[sale_code]',
							w_reply = '$w_reply',
							w_catecode = '$w_catecode',
							w_comment = '$w_comment',
							w_subject = '$w_subject',
							w_content = '$w_content',
							w_hit = '$w_hit',
							w_name = '$w_name',
							w_company_name = '$w_company_name',
							w_email = '$w_email',
							w_hp = '$w_hp',
							w_ip = '$ip',
							w_count_file = '$w_count_file',
							w_count_image = '$w_count_image',
							w_notice = '$w_notice',						
							w_main_exposure = '$w_main_exposure',	
							w_rink	 = '$w_rink',
							w_open_date	 = '$w_open_date',
							".$img_update."
							w_blank = '$w_blank',
							w_person = '$w_person',
							w_condition = '1',
							w_datetime ='$date'";
					sql_query($sql);

				alert('정상적으로 작성 하였습니다.',''.MARI_HOME_URL.'/?cms=cs_bbs_list&gr_id='.$gr_id.'&type='.$type.'&table='.$table.'&skin='.$skin.'');
		}else if($type=="visit"){

			/*insert*/
				$sql = " insert into mari_write 
							set w_table = '$table', 
							".$pw_yes."
							w_num = '$w_num',
							m_id = '$mysv[sale_code]',
							w_reply = '$w_reply',
							w_catecode = '$w_catecode',
							w_comment = '$w_comment',
							w_subject = '$w_subject',
							w_content = '$w_content',
							w_hit = '$w_hit',
							w_name = '$w_name',
							w_email = '$w_email',
							w_hp = '$w_hp',
							w_ip = '$ip',
							w_count_file = '$w_count_file',
							w_count_image = '$w_count_image',
							w_notice = '$w_notice',						
							w_main_exposure = '$w_main_exposure',	
							w_rink	 = '$w_rink',
							".$img_update."
							w_blank = '$w_blank',
							w_person = '$w_person',
							w_condition = '1',
							w_datetime ='$date'";
					sql_query($sql);

				alert('정상적으로 작성 하였습니다.','?mode=customer');
		/*기본모드를 default로한다.*/
		}else if($type=="default"){


			/*insert*/
				$sql = " insert into mari_write 
							set w_table = '$table', 
							".$pw_yes."
							w_num = '$w_num',
							m_id = '$mysv[sale_code]',
							w_reply = '$w_reply',
							w_catecode = '$w_catecode',
							w_comment = '$w_comment',
							w_subject = '$w_subject',
							w_content = '$w_content',
							w_hit = '$w_hit',
							w_name = '$w_name',
							w_company_name = '$w_company_name',
							w_email = '$w_email',
							w_hp = '$w_hp',
							w_ip = '$ip',
							w_count_file = '$w_count_file',
							w_count_image = '$w_count_image',
							w_notice = '$w_notice',						
							w_main_exposure = '$w_main_exposure',	
							w_rink	 = '$w_rink',
							w_open_date	 = '$w_open_date',
							".$img_update."
							w_blank = '$w_blank',
							w_person = '$w_person',
							w_condition = '1',
							w_datetime ='$date',
							urgency = '$urgency',
							w_url_path = '$w_url_path'";
					sql_query($sql);

					alert('정상적으로 작성 하였습니다.',''.MARI_HOME_URL.'/?cms=cs_bbs_list&gr_id='.$gr_id.'&type='.$type.'&table='.$table.'&skin='.$skin.'');

		}else if($type=="m"){

		$sql = " select  file_img from  mari_write  where table='$table' and w_id='$w_id' and m_id = '".$mysv[sale_code]."";
		$d_file = sql_fetch($sql, false);
		/*file 삭제*/
		if($d_img=="1"){
			$img_update="file_img	 = '',";
			@unlink(MARI_DATA_PATH."/".$table."/".$d_file[file_img]."");
			// 썸네일삭제
			if(preg_match("/\.(".$config['c_image_upload'].")$/i", $d_file['file_img'])) {
				delete_board_thumbnail($table, $d_file['file_img']);
			}
		}

			/*update*/
				$sql = " update  mari_write
							set ".$pw_yes."
							w_num = '-".$w_id."',
							w_reply = '$w_reply',
							w_catecode = '$w_catecode',
							w_comment = '$w_comment',
							w_subject = '$w_subject',
							w_content = '$w_content',
							w_hit = '$w_hit',
							m_id = '$mysv[sale_code]',
							w_name = '$w_name',
							w_email = '$w_email',
							w_hp = '$w_hp',
							w_ip = '$ip',
							w_count_file = '$w_count_file',
							w_count_image = '$w_count_image',
							w_notice = '$w_notice',
							w_main_exposure = '$w_main_exposure',
							w_rink	 = '$w_rink',
							w_blank = '$w_blank',
							w_person = '$w_person',
							".$img_update."
							w_last ='$date'
							where w_table='$table' and w_id = '$w_id' and m_id = '".$mysv[sale_code]."";
					sql_query($sql);
				alert('정상적으로 수정 되었습니다.',''.MARI_HOME_URL.'/?cms=cs_bbs_list&type='.$type.'&table='.$table.'&skin='.$skin.'');
		}else if($type=="d"){
			/*delete*/
				$sql = " delete from mari_write where w_id='".$w_id."' and m_id = '".$mysv[sale_code]."";
				sql_query($sql);
				alert('정상적으로 삭제처리 하였습니다.',''.MARI_HOME_URL.'/?cms=cs_bbs_list&type='.$type.'&table='.$table.'&skin='.$skin.'');
		}else{
		alert('정상적인 접근이 아닙니다.');
		}
	}else{
		alert('정상적인 접근이 아닙니다.');
	}



?>