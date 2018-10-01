<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
{# new_header}
<!-- /////////////////////////////// 본문 시작 /////////////////////////////// -->
<div id="container" class="sub">
	<!-- Sub title -->
	<h2 class="subtitle t2"><span class="motion" data-animation="flash">언론보도</span></h2>
	<!-- 펀딩 언론보도 -->
	<div class="board">
		<div class="container">
			<!-- 검색 -->
			<!--form action="">
				<div class="board_sch">
					<p class="txt_sch"><input type="text" placeholder="언론보도 검색"></p>
					<button class="btn_sch" type="submit">검색</button>
				</div>
			</form-->
			<h3>케이펀딩 언론보도</h3>
			<!-- 게시판 테이블 -->
			<ul class="board_ul">

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
				<!-- loop start -->



				<li>
					<p class="img"><?php if(!$row[file_img]){?><img src="{MARI_HOMESKIN_URL}/img/no_image.gif" width="<?php echo $bbs_config['bo_image_width'];?>" height="<?php echo $bbs_config['bo_image_height'];?>" /><?php }else{?><img src="<?php echo $view_img;?>" width="<?php echo $bbs_config['bo_image_width'];?>" height="<?php echo $bbs_config['bo_image_height'];?>" alt="<?php echo $row['w_subject'];?>" /><?php }?></p>
          <?php if($row['w_logo']){?>
          <p class="c_logo">
            <span>
              <img class="newsp" src="<?php echo MARI_DATA_URL?>/<?php echo $row['w_table']?>/<?php echo $row['w_logo']?>" width="124px" height="29px" alt=""/>
            </span>
          </p>
          <?php }?>
					<p class="tt"><?php echo $row['w_subject'];?></p>
					<p class="txt"><?php echo strip_tags($row['w_content']);?></p>
					<span class="date"><?php echo substr($row['w_datetime'],0,10); ?></span>
          <a href="<?php echo $row['w_rink'];?>" target="_blank" class="btn_detail">자세히 보기 ></a>
				</li>
				<!-- loop end -->
        <?php
        }
        if ($i == 0){?>
             <img src='{MARI_HOMESKIN_URL}/img/no_list.png' alt=''/ class="center">
        <?php }?>
			</ul>
      	<style>
div.p_num1{
  width: 100%;
max-width: 300px;
margin: 50px auto;
text-align: center;
}
div.p_num1 ul{
  display: inline-block;
    padding-left: 0;
    margin: 20px 0;
    border-radius: 4px;
}
div.p_num1 ul > li {
    display: inline;
}
div.p_num1 >ul>li>a, div.p_num1>li>span {
    position: relative;
    float: left;
    margin-left: -1px;
    line-height: 1.42857143;
    color: #333;
    text-decoration: none;
    background-color: #fff;
    border: 1px solid #ddd;
    padding: 3px 8px;
    border: 1px solid #333;
    margin: 0 3px;
}
div.p_num1 >ul>li>a.p_on1{
  color:white;
  background-color: #333;
}
        </style>

			<!-- 페이징 -->
      <!--
			<p class="paging">

				<span class="prev"><a href="#" target="_self">이전</a></span>
				<span class="on">1</span>
				<span><a href="#" target="_self">2</a></span>
				<span><a href="#" target="_self">3</a></span>
				<span><a href="#" target="_self">4</a></span>
				<span><a href="#" target="_self">5</a></span>
				<span class="next"><a href="#" target="_self">다음</a></span>
			</p>
    -->
      <div class="paging2">
        <?php echo get_paging($bbs_config['bo_page_rows'], $page, $total_page, '?mode='.$mode.'&table='.$table.'&subject='.$subject.'&type='.$type.''.$qstr.'&amp;page='); ?>
      </div><!-- /paging -->

		</div>
	</div>
</div>
<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->
{# new_footer}
