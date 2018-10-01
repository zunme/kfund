<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

<ul class="ui_bar">
			<!-- <li class="admin_box">
				<div><a href="#"><img src="{MARI_ADMINSKIN_URL}/img/admin_img.png" alt="관리자"></a></div> -->
				<!--<div><a href="#"><img src="{MARI_ADMINSKIN_URL}/img/my_btn.png" alt="마이페이지"></a></div>-->
					<!-- <?php if(!$member_ck){?>
				<div><a href="{MARI_HOME_URL}/?cms=admin_login"><img src="{MARI_ADMINSKIN_URL}/img/login_btn.png" alt="로그아웃"></a></div>
					<?php }else{?>
				<div><a href="{MARI_HOME_URL}/?cms=admin_logout"><img src="{MARI_ADMINSKIN_URL}/img/logout_btn.png" alt="로그아웃"></a></div>
					<?php }?>
			</li> -->
			<li>
				<?php if(!$member_ck){?>
				<a href="{MARI_HOME_URL}/?cms=admin_login"><img src="{MARI_ADMINSKIN_URL}/img/left_ui1.png" alt="로그아웃"></a>
				<?php }else{?>
				<a href="{MARI_HOME_URL}/?cms=admin_logout"><img src="{MARI_ADMINSKIN_URL}/img/left_ui1.png" alt="로그아웃"></a>
				<?php }?>
			</li>
			<?php
				$sql = "select * from mari_mysevice_config";
				$code = sql_fetch($sql,false);
			?>
			<li><a href="{MARI_HOME_URL}/?cms=board_list_pop2&ftp_id=<?php echo $code['ftp_id'];?>"  onclick="window.open(this.href, '','width=1000, height=850, resizable=no, scrollbars=yes, status=no'); return false"><img src="{MARI_ADMINSKIN_URL}/img/left_ui2.png" alt="1:1문의"></a></li>
			<li><a href="{MARI_HOME_URL}/?cms=design_main"><img src="{MARI_ADMINSKIN_URL}/img/left_ui3.png" alt="디자인관리"></a></li>
<?php if($user[m_id]=="webmaster@admin.com"){?>
			<li><a href="{MARI_HOME_URL}/?cms=setting_main"><img src="{MARI_ADMINSKIN_URL}/img/left_ui4.png" alt="환경설정"></a></li>
<?php }?>
			<li><a href="{MARI_HOME_URL}/manual" target="_blank"><img src="{MARI_ADMINSKIN_URL}/img/left_ui5.png" alt="매뉴얼"></a></li>
			<li style="text-align:center;color:white;font-size:14px;margin-top:5px;"><a href="http://kfunding.co.kr/api/index.php/castboard"  target="_blank" style="text-align:center;color:white;font-size:14px;">CAST</a></li>
		</ul><!-- /ui_bar -->
