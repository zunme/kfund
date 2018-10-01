<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 언론보도&인터뷰
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->

<?php $mobile_agent = '/(Android|BlackBerry|SymbianOS|SCH-M\d+|Opera Mini|Windows CE|Nokia|SonyEricsson|webOS|PalmOS|iPod|iPhone)/';

/*모바일 모드일 경우*/
if(preg_match($mobile_agent, $_SERVER['HTTP_USER_AGENT'])) {

?>
{#header}


 <section id="container">
		<section id="sub_content">
			<div class="customer_wrap">
				<div class="container">
					<h3 class="s_title1 pt20">언론보도</h3>
					<div class="customer_inner1">
					<ul class="media_list">

	<?php

	$sql ="select count(*) as cnt from mari_write where w_table = 'media'  order by w_datetime desc";
	$row = sql_fetch($sql);
	$total_count = $row['cnt'];
	$rows = 5;
	$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
	if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
	$from_record = ($page - 1) * $rows; // 시작 열을 구함

	$sql ="select * from mari_write where w_table = 'media'  order by w_datetime desc limit $from_record, $rows";
	$ud = sql_query($sql, false);

	for ($i=0;  $row=sql_fetch_array($ud); $i++){
	$view_img = MARI_DATA_URL."/$table/".$row[file_img]."";



	?>
						<li>

		<?php if(!$row[file_img]){?>
								<div class="media_img1"><img src="{MARI_HOMESKIN_URL}/img/no_image.gif" width="<?php echo $bbs_config['bo_image_width'];?>" height="<?php echo $bbs_config['bo_image_height'];?>" /></div>
							<?php }else{?>
								<div class="media_img1"><img src="<?php echo $view_img;?>" width="<?php echo $bbs_config['bo_image_width'];?>" height="<?php echo $bbs_config['bo_image_height'];?>" alt="<?php echo $row['w_subject'];?>" /></div>
							<?php }?>
							<div class="media_lst_cont1">

								<h4 class="media_title1"><?php echo $row['w_subject'];?></h4>
								<p class="media_txt1"><?php echo strip_tags($row['w_content']);?></p>
								<!--<p class="media_date1">Date <?php echo substr($list['w_datetime'],0,10); ?></p>-->
								<div class="article_more"><a href="<?php echo $row['w_rink'];?>" <?php if($row['w_blank']=="Y"){?> target="_blank"<?php }?>>자세히보기</a></div>
							</div>
						</li>
    <?php
    }
    if ($i == 0)
        echo "<li>게시물이 없습니다.</li>";
    ?>

					</ul><!-- /media_list -->
					<div class="paging">
			<!--패이징--><?php echo get_paging($bbs_config['bo_page_rows'], $page, $total_page, '?mode='.$mode.'&table='.$table.'&subject='.$subject.'&type='.$type.'&amp;page='); ?>
					</div><!-- /paging -->


</div><!-- /customer_inner1 -->
				</div>
			</div><!-- /mypage_wrap -->
		</section><!-- /sub_content -->
	</section><!-- /container -->




<?}else{?>
{#header_sub}
		<div id="container">


			<div id="sub_content">

				<div class="service_wrap">
					<ul class="tab_btn1">
						<li><a href="{MARI_HOME_URL}/?mode=bbs_list&table=notice&subject=공지사항">공지사항</a></li>
						<li class="tab_on1"><a href="{MARI_HOME_URL}/?mode=bbs_list&table=media&subject=언론보도&인터뷰">언론보도</a></li>
						<li><a href="{MARI_HOME_URL}/?mode=bbs_list&table=qna&subject=문의하기">문의하기</a></li>
					</ul>

				<div class="media_wrap">

					<ul class="media_list">
	<?php

	$sql ="select count(*) as cnt from mari_write where w_table = 'media'  order by w_datetime desc";
	$row = sql_fetch($sql);
	$total_count = $row['cnt'];
	$rows = 5;
	$total_page  = ceil($total_count / $rows);  // 전체 페이지 계산
	if ($page < 1) $page = 1; // 페이지가 없으면 첫 페이지 (1 페이지)
	$from_record = ($page - 1) * $rows; // 시작 열을 구함

	$sql ="select * from mari_write where w_table = 'media'  order by w_datetime desc limit $from_record, $rows";
	$ud = sql_query($sql, false);

	for ($i=0;  $row=sql_fetch_array($ud); $i++){
	$view_img = MARI_DATA_URL."/$table/".$row[file_img]."";



	?>
						<li>
							<!--<div class="media_img1"><img src="<?php echo $view_img;?>" alt="<?php echo $list['w_subject'];?>" /></div>-->
							<?php if(!$row[file_img]){?>
								<div class="media_img1"><img src="{MARI_HOMESKIN_URL}/img/no_image.gif" width="<?php echo $bbs_config['bo_image_width'];?>" height="<?php echo $bbs_config['bo_image_height'];?>" /></div>
							<?php }else{?>
								<div class="media_img1"><img src="<?php echo $view_img;?>" width="<?php echo $bbs_config['bo_image_width'];?>" height="<?php echo $bbs_config['bo_image_height'];?>" alt="<?php echo $row['w_subject'];?>" /></div>
							<?php }?>
							<div class="media_lst_cont1">
								<?php if($row['w_logo']){?>
								<img class="newsp" src="<?php echo MARI_DATA_URL?>/<?php echo $row['w_table']?>/<?php echo $row['w_logo']?>" width="124px" height="29px" alt=""/>
								<?php }?>
								<p class="press"><span class="upload_date"><?php echo substr($row['w_datetime'],0,10); ?></span></p>
								<h4 class="media_title1"><?php echo $row['w_subject'];?></h4>
								<div class="media_txt1"><p><?php echo strip_tags($row['w_content']);?></p></div>
								<p class="btn_news_more"><a href="<?php echo $row['w_rink'];?>" <?php if($list['w_blank']=="Y"){?> target="_blank"<?php }?>>자세히 보기 ></a></p>
							</div>
						</li>
							    <?php

    }
  if ($i == 0){?>
       <img src='{MARI_HOMESKIN_URL}/img/no_list.png' alt=''/ class="center">
  <?php }?>


					</ul><!-- /media_list -->
					<div class="paging">
			<!--패이징--><?php echo get_paging($bbs_config['bo_page_rows'], $page, $total_page, '?mode='.$mode.'&table='.$table.'&subject='.$subject.'&type='.$type.''.$qstr.'&amp;page='); ?>
					</div><!-- /paging -->
					<!-- <div class="more_btn2 mt40"><a href="#" class="hidden">더보기</a></div> -->
				</div><!-- /media_wrap -->
			</div><!-- /sub_content -->
		</div><!-- /container -->





<?}?>

{# footer}<!--하단-->
