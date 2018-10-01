<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include_once(MARI_EDITOR_LIB);
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 게시판 쓰기
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# header}<!--상단-->

<link rel="stylesheet" type="text/css" href="{MARI_HOMESKIN_URL}/css/jquery_ui.css" />

<style>
    #wrap,html{background:#fff}
</style>
<main class="service_wrap">
    <section>
   
        <h3>제품문의<br/><span>도움이 필요한 서비스를 선택하여 주세요.</span></h3>
    </section>
    
    <section class="commonness_service">
<form name="write_form"  method="post" enctype="multipart/form-data">
<input type="hidden" name="w_id" value="<?php echo $w['w_id']; ?>">
<input type="hidden" name="table" value="<?php echo $table; ?>">
<input type="hidden" name="subject" value="<?php echo $subject; ?>">
<input type="hidden" name="type" value="default"><!--기본일경우 default-->
<input type="hidden" name="nextat" value="service_p2p5"><!--다음액션이 있을경우 다음액션에 들어갈 mode또는 cms명-->
   
        <div class="p2p2">
            <p class="commonness_title">
                <span>제품문의 > P2P신용대출 플랫폼</span>     <a href="{MARI_HOME_URL}/?mode=service_main">서비스 다시 선택하기</a>
            </p>
            <p class="p2p_3_title"><span class="title_point">*</span>  필수 입력항목입니다.</p>
                <div class="service_form_wrap2">
                    <p>
                        <strong>
                            <span class="title_point">*</span>회사명
                        </strong>
                        <span class="service_login">
                            <input type="text" class="login_input0" name="w_company_name" value="<?php echo $user['m_company_name'];?>" placeholder="회사명" style="width:160px;">
                        </span>
                        <strong>
                            <span class="title_point">*</span>담당자
                        </strong>
                        <span class="service_login">
                            <input type="text" class="login_input0" name="w_name" value="<?php echo $user['m_name'];?>" placeholder="담당자명" style="width:160px;">
                        </span>
                    </p>
                    <p>
                        <strong>
                            <span class="title_point">*</span>연락처
                        </strong>
                        <span class="service_login">
                            <input type="text" class="login_input0" name="w_hp" value="<?php echo $user['m_hp'];?>" required placeholder="휴대폰 번호 예) 010xxxxxxxx" maxlength="11" onkeyup="cnj_comma(this);" onchange="cnj_comma(this);" style="width:160px;" >
                        </span>
                        <strong>
                            <span class="title_point">*</span>이메일
                        </strong>
                        <span class="service_login">
                            <input type="text" class="login_input0" name="w_email" value="<?php echo $user['m_email'];?>"  placeholder="이메일 주소" onkeyup="warring(this);" onchange="warring(this);" style="width:160px;">
                        </span>
                    </p>
                    <p>
                        <label>
                            <span class="title_point">*</span><span class="title_point2">제목</span>
                            <input type="text" class="login_input1" name="w_subject" value="<?php echo $w['w_subject'];?>">
                        </label>
                    </p>
                    <p>
                        <label>
                            <span class="title_point">*</span><span class="title_point2">내용</span>
								<?php 
								 /*에디터 사용시에만 에디터노출*/
								if($bbs_config['bo_use_editor']=="Y"){
								?>
								<?php if($type=="w" || $bbs_config['bo_insert_content']){?>
									<?php echo editor_html('w_content', $bbs_config['bo_insert_content']); ?>
								<?php }else{?>
									<?php echo editor_html('w_content', $w['w_content']); ?>
								<?php }?>
								<?php }else{?>
									<textarea name="w_content"><?php echo $w['w_content'];?></textarea>
								<?php }?>
                        </label>
                    </p>
                    <p>
                        
                        <label class="ml5"><span class="title_point2">예상 도입시기</span>
                            <input type="text" name="w_open_date" value="<?php echo $w['w_open_date'];?>" id="" size=""  class="login_input2 calendar" placeholder="클릭하세요."/>
                            
                        </label> 
                    </p>
                    <div class="file_input">
                        <span class="title_point2">첨부파일</span>
                        <input type="text" readonly="readonly" title="File Route" id="file_route" value="파일없음" class="login_input3">
                        <label>
                            파일선택
                            <input type="file" name="u_img" onchange="javascript:document.getElementById('file_route').value=this.value">

										    <?php
										    $viewimg_str_01 = "";
										    $view_img = MARI_DATA_PATH."/$table/".$w[file_img]."";
										    if (file_exists($view_img) && $w[file_img]) {
											$size = @getimagesize($view_img);
											if($size[0] && $size[0] > 320)
											    $width = 320;
											else
											    $width = $size[0];

											echo '<input type="checkbox" name="d_img" value="1" id="d_img"> <label for="d_img">삭제</label>';
											$viewimg_str_01 = '<img src="'.MARI_DATA_URL.'/'.$table.'/'.$w[file_img].'" width="'.$width.'">';
										    }
										    if ($viewimg_str_01) {
											echo '<div class="banner_or_img">';
											echo $viewimg_str_01;
											echo '</div>';
										    }
										    ?>

                        </label>
                       
                    </div>
                </div>
                <div class="service_next_box">
                     <a href="javascript:history.back();">이전</a> <a href="#" id="write_form_add" >접수</a>
                </div>
            </div>
            
     
        </form>
    </section>
    
</main>



<script>
/*필수체크*/
$(function() {
	$('#write_form_add').click(function(){
		Write_form_Ok(document.write_form);
	});
});


function Write_form_Ok(f)
{
<?php if(!$member_ck){?>
	if(!f.w_name.value){alert('\n담당자명을 입력하여 주십시오.');f.w_name.focus();return false;}
	if(!f.w_company_name.value){alert('\n회사명을 입력하여 주십시오.');f.w_company_name.focus();return false;}
	if(!f.w_email.value){alert('\n이메일을 설정하여 주십시오.');f.w_email.focus();return false;}

	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	
	if(exptext.test(f.w_email.value)==false){
		//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우
		alert("이메일 형식이 올바르지 않습니다.");
		f.w_email.focus(); return false;
	}
	if(!f.w_hp.value){alert('\n휴대폰번호를 입력하여 주십시오.');f.w_email.focus();return false;}
<?php }?>
	if(!f.w_subject.value){alert('\n제목을 입력하여 주십시오.');f.w_subject.focus();return false;}
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=bbs_write&type=<?php echo $type;?>';
	f.submit();
}


/*삭제처리*/
$(function() {
	$('#write_delete').click(function(){
	next_d(document.write_form);
	});
});


function next_d(f)
{
  if(confirm("정말 삭제처리 하시겠습니까? 삭제 후에는 해당 게시물의 모든 정보가 삭제되오니 주의하시기 바랍니다."))
  {
	f.method = 'post';
	f.action = '{MARI_HOME_URL}/?up=bbs_write&type=d';
	f.submit();
  }
}


function cnj_comma(cnj_str) { 
		var t_align = "left"; // 텍스트 필드 정렬
		var t_num = cnj_str.value.substring(0,1); // 첫글자 확인 변수
		var num =  /^[/,/,0,1,2,3,4,5,6,7,8,9,/]/; // 숫자와 , 만 가능
		var cnjValue = ""; 
		var cnjValue2 = "";

		if (!num.test(cnj_str.value))   {
		alert('숫자만 입력하십시오. 특수문자와 한글/영문은 사용할수 없습니다.');
		cnj_str.value="";
		cnj_str.focus();
		return false;
		}

		if ((t_num < "0" || "9" < t_num)){
		alert("숫자만 입력하십시오.");
		cnj_str.value="";
		cnj_str.focus();
		return false;
		}

		for(i=0; i<cnj_str.value.length; i++)      {   
		if(cnj_str.value.charAt(cnj_str.value.length - i -1) != ",") { 
		cnjValue2 = cnj_str.value.charAt(cnj_str.value.length - i -1) + cnjValue2; 
		} 
		}

		for(i=0; i<cnjValue2.length; i++)         {

		if(i > 0 && (i%3)==0) { 
		cnjValue = cnjValue2.charAt(cnjValue2.length - i -1) + "," + cnjValue; 
		} else { 
		cnjValue = cnjValue2.charAt(cnjValue2.length - i -1) + cnjValue; 
		} 
		}
		cnj_str.value = cnjValue;
		cnj_str.style.textAlign = t_align;
}

								/*아이디 공백입력 못하게*/
								function warring(cnj_str) { 
									var t_num = cnj_str.value.substring(0,1); // 첫글자 확인 변수
									var num =  /^[/,/,0,1,2,3,4,5,6,7,8,9,/]/; // 숫자와 , 만 가능
									var a_num = cnj_str.value;
									var cnjValue = ""; 
									var cnjValue2 = "";
									
									if(a_num.indexOf(" ") >= 0 ){
										alert("공백은 입력하실 수 없습니다.");
										cnj_str.value="";
										cnj_str.focus();
										return false;
									}
								}
								//이름 한글입력만 받기
								function warring2(cnj_str) { 

									if((event.keyCode < 12592) || (event.keyCode > 12687))
									event.returnValue = false
								}

            $('.calendar').datepicker({
                 changeMonth: true,
                 changeYear: true,
                 dateFormat: 'yy-mm-dd',
                 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 dayNamesMin: ['<font color=red>일</font>','월','화','수','목','금','토'],showMonthAfterYear: true,
                 closeText: '닫기',prevText: '이전달',	nextText: '다음달',currentText: '오늘',firstDay: 0,
             });
</script>




{# footer}<!--하단-->
