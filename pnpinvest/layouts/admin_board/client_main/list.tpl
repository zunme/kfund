<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
include(MARI_VIEW_PATH.'/imwork.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ ADMIN analytics.tpl
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# s_header}<!--상단-->
<div id="wrapper">
	<div id="left_container">
		{# left_bar}
		<div class="lnb_wrap">
			<div class="title01">환경설정</div>
			{# lnb}<!--메인메뉴-->
		</div><!-- /lnb_wrap -->
	</div><!-- /left_container -->

	<div id="client_container">
		<div class="client_containerinner">

<?php if($master['imwork_use']=="N"){
?>
			<section class="client_s01">
				<div class="ingstep">
					<h3>문의 현황</h3>
					<div  class="btn_client">
						<a href="{MARI_HOME_URL}/?cms=cs_bbs_list&gr_id=productInquiry&table=service_p2p1&skin=service_p2p1">문의현황 바로가기</a>
					</div>
					 <ul>
					 <li><p><img src="{MARI_ADMINSKIN_URL}/img/service_icon01.png"></p><p>접수<span><a href="{MARI_HOME_URL}/?cms=cs_bbs_list&gr_id=productInquiry&table=service_p2p1&skin=service_p2p1&status=W"><?php echo number_format($status_W);?></a></span></p></li>
					 <li><p><img src="{MARI_ADMINSKIN_URL}/img/service_icon03.png"></p><p>진행중<span><a href="{MARI_HOME_URL}/?cms=cs_bbs_list&gr_id=productInquiry&table=service_p2p1&skin=service_p2p1&status=P"><?php echo number_format($status_P);?></a></span></p></li>
					 <li><p><img style="padding-top:5px;" src="{MARI_ADMINSKIN_URL}/img/service_icon04.png"></p><p>완료<span><a href="{MARI_HOME_URL}/?cms=cs_bbs_list&gr_id=productInquiry&table=service_p2p1&skin=service_p2p1&status=C"><?php echo number_format($status_C);?></a></span></p></li>
					 <li><p><img src="{MARI_ADMINSKIN_URL}/img/service_icon02.png"></p><p>재문의<span><a href="{MARI_HOME_URL}/?cms=cs_bbs_list&gr_id=productInquiry&table=service_p2p1&skin=service_p2p1&status=R"><?php echo number_format($status_R);?></a></span></p></li>
					 </ul>
				 </div><!-- ingstep -->
				 <div class="client_main">
					<h3>신규 문의</h3>
					<ul>

					   <li>
						   <strong>운영문의</strong>
						   <div>
							   <img src="{MARI_ADMINSKIN_URL}/img/service_icon3.jpg" alt="">
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=operationalinquiry&subject=운영문의&ptype=호스팅문의&setting=prototype&step=01&skin=service_p2p1">호스팅문의</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=operationalinquiry&subject=운영문의&ptype=기능문의&setting=prototype&step=01&skin=service_p2p1">기능문의</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=operationalinquiry&subject=운영문의&ptype=투자/대출기능&setting=prototype&step=01&skin=service_p2p1">투자/대출 기능</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=operationalinquiry&subject=운영문의&ptype=회원정보관련&setting=prototype&step=01&skin=service_p2p1">회원정보 관련</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=operationalinquiry&subject=운영문의&ptype=PG관련문의&setting=prototype&step=01&skin=service_p2p1">PG 관련문의</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=operationalinquiry&subject=운영문의&ptype=업그레이드문의&setting=prototype&step=01&skin=service_p2p1">업그레이드 문의</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=operationalinquiry&subject=운영문의&ptype=기타&setting=prototype&step=01&skin=service_p2p1">기타</a></p>
						   </div>
					   </li>
					   <li>
						   <strong>기술지원</strong>
						   <div>
							   <img src="{MARI_ADMINSKIN_URL}/img/service_icon4.jpg" alt="">
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=technicalsupport&subject=기술지원&ptype=변경요청&setting=prototype&step=01&skin=service_p2p1">변경요청</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=technicalsupport&subject=기술지원&ptype=오류수정요청&setting=prototype&step=01&skin=service_p2p1">오류 수정 요청</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=technicalsupport&subject=기술지원&ptype=업그레이드지원&setting=prototype&step=01&skin=service_p2p1">업그레이드 지원</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=technicalsupport&subject=기술지원&ptype=기술지원요청&setting=prototype&step=01&skin=service_p2p1">기술지원 요청</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=technicalsupport&subject=기술지원&ptype=원격지원&setting=prototype&step=01&skin=service_p2p1">원격지원</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=technicalsupport&subject=기술지원&ptype=기타&setting=prototype&step=01&skin=service_p2p1">기타</a></p>
						   </div>
					   </li>
					   <li>
						   <strong>방문상담문의</strong>
						   <div>
							   <img src="{MARI_ADMINSKIN_URL}/img/service_icon5.jpg" alt="">
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=visitingconsultation&subject=방문상담&ptype=방문상담&setting=prototype&step=01&skin=service_p2p1">방문상담 문의</a></p>  
						   </div>              
					   </li>
					   <li>
						   <strong>안내</strong>
						   <div>
							   <img src="{MARI_ADMINSKIN_URL}/img/service_icon6.jpg" alt="">
							   <!--<p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=faq&subject=FAQ&ptype=FAQ&setting=prototype&step=01&skin=service_p2p1">FAQ</a></p>-->
							   <p><a  href="http://intowinsoft.co.kr/play/data/file/user_manual.pdf" download target="_blank">사용메뉴얼</a></p>
							   <p><a href="http://intowinsoft.co.kr/play/data/file/charge_technology.pdf" download target="_blank">고객지원정책</a></p>
						   </div>
					   </li>
					</ul>
				</div><!-- client_main -->
			</section>
<?php }else if($master['imwork_use']=="Y" || $imwork_use=="Y"){
/*IM서비스 이용중일경우 imwork_use:Y 2번째 OR체크는 테스트용*/
	if($gr_id=="project"){
		header("Location: ?cms=cs_bbs_list&gr_id=productInquiry&table=modified&subject=클라이언트메인&skin=client_main"); 
	}

?>
			<section class="client_s01">
				<div class="ingstep">
					<h3>문의 현황</h3>
					<div  class="btn_client">
						<a href="{MARI_HOME_URL}/?cms=cs_bbs_list&gr_id=productInquiry&table=service_p2p1&skin=service_p2p1">문의현황 바로가기</a>
					</div>
					 <ul>
					 <li><p><img src="{MARI_ADMINSKIN_URL}/img/service_icon01.png"></p><p>접수<span><a href="{MARI_HOME_URL}/?cms=cs_bbs_list&gr_id=productInquiry&table=service_p2p1&skin=service_p2p1&status=W"><?php echo number_format($status_W);?></a></span></p></li>
					 <li><p><img src="{MARI_ADMINSKIN_URL}/img/service_icon03.png"></p><p>진행중<span><a href="{MARI_HOME_URL}/?cms=cs_bbs_list&gr_id=productInquiry&table=service_p2p1&skin=service_p2p1&status=P"><?php echo number_format($status_P);?></a></span></p></li>
					 <li><p><img style="padding-top:5px;" src="{MARI_ADMINSKIN_URL}/img/service_icon04.png"></p><p>완료<span><a href="{MARI_HOME_URL}/?cms=cs_bbs_list&gr_id=productInquiry&table=service_p2p1&skin=service_p2p1&status=C"><?php echo number_format($status_C);?></a></span></p></li>
					 <li><p><img src="{MARI_ADMINSKIN_URL}/img/service_icon02.png"></p><p>재문의<span><a href="{MARI_HOME_URL}/?cms=cs_bbs_list&gr_id=productInquiry&table=service_p2p1&skin=service_p2p1&status=R"><?php echo number_format($status_R);?></a></span></p></li>
					 </ul>
				 </div><!-- ingstep -->
				 <div class="client_main">
					<h3>신규 문의</h3>
					<ul>

					   <li>
						   <strong>운영문의</strong>
						   <div>
							   <img src="{MARI_ADMINSKIN_URL}/img/service_icon3.jpg" alt="">
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=operationalinquiry&subject=운영문의&ptype=호스팅문의&setting=prototype&step=01&skin=service_p2p1">호스팅문의</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=operationalinquiry&subject=운영문의&ptype=기능문의&setting=prototype&step=01&skin=service_p2p1">기능문의</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=operationalinquiry&subject=운영문의&ptype=투자/대출기능&setting=prototype&step=01&skin=service_p2p1">투자/대출 기능</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=operationalinquiry&subject=운영문의&ptype=회원정보관련&setting=prototype&step=01&skin=service_p2p1">회원정보 관련</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=operationalinquiry&subject=운영문의&ptype=PG관련문의&setting=prototype&step=01&skin=service_p2p1">PG 관련문의</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=operationalinquiry&subject=운영문의&ptype=업그레이드문의&setting=prototype&step=01&skin=service_p2p1">업그레이드 문의</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=operationalinquiry&subject=운영문의&ptype=기타&setting=prototype&step=01&skin=service_p2p1">기타</a></p>
						   </div>
					   </li>
					   <li>
						   <strong>기술지원</strong>
						   <div>
							   <img src="{MARI_ADMINSKIN_URL}/img/service_icon4.jpg" alt="">
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=technicalsupport&subject=기술지원&ptype=변경요청&setting=prototype&step=01&skin=service_p2p1">변경요청</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=technicalsupport&subject=기술지원&ptype=오류수정요청&setting=prototype&step=01&skin=service_p2p1">오류 수정 요청</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=technicalsupport&subject=기술지원&ptype=업그레이드지원&setting=prototype&step=01&skin=service_p2p1">업그레이드 지원</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=technicalsupport&subject=기술지원&ptype=기술지원요청&setting=prototype&step=01&skin=service_p2p1">기술지원 요청</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=technicalsupport&subject=기술지원&ptype=원격지원&setting=prototype&step=01&skin=service_p2p1">원격지원</a></p>
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=technicalsupport&subject=기술지원&ptype=기타&setting=prototype&step=01&skin=service_p2p1">기타</a></p>
						   </div>
					   </li>
					   <li>
						   <strong>방문상담문의</strong>
						   <div>
							   <img src="{MARI_ADMINSKIN_URL}/img/service_icon5.jpg" alt="">
							   <p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=visitingconsultation&subject=방문상담&ptype=방문상담&setting=prototype&step=01&skin=service_p2p1">방문상담 문의</a></p>  
						   </div>             
					   </li>
					   <li>
						   <strong>안내</strong>
						   <div>
							   <img src="{MARI_ADMINSKIN_URL}/img/service_icon6.jpg" alt="">
							   <!--<p><a href="{MARI_HOME_URL}/?cms=cs_bbs_write&gr_id=productInquiry&type=w&table=faq&subject=FAQ&ptype=FAQ&setting=prototype&step=01&skin=service_p2p1">FAQ</a></p>-->
							   <p><a  href="http://intowinsoft.co.kr/play/data/file/user_manual.pdf" download target="_blank">사용메뉴얼</a></p>
							   <p><a href="http://intowinsoft.co.kr/play/data/file/charge_technology.pdf" download target="_blank">고객지원정책</a></p>
						   </div>
					   </li>
					</ul>
				</div><!-- client_main -->
			</section>
<?php }else if($master['imwork_use']=="P"){
/*프로젝트시작일경우*/
?>


			<section class="client_s02">
				<div class="s_top">
					<h3>진행 현황</h3>
					<p><span>착수일</span><span><?php echo $startdate;?></span></p>
					<div  class="companyPbar" >
						<div class="companyPpecent" style="width:<?php echo $newprogress;?>%;">
							<p>
								<span><?php echo $newprogress;?>%</span>
								<span><img src="{MARI_ADMINSKIN_URL}/img/ico_here01.png" alt=""></span>
								<span><img src="{MARI_ADMINSKIN_URL}/img/ico_here02.png" alt=""></span>
							</p>
						</div>
					</div><!-- companyPbar -->
					<p><span>완료일</span><span><?php echo $enddate;?></span></p>
				</div>
				<div class="s_list">
					<h3>단계별 진행 현황</h3>
					<div>
						<p>디자인</p>
						<div  class="companyPbar" >
							<div class="companyPpecent" style="width:<?php echo $prodata['w_design_pct'];?>%; background:#dd4b39;">
								<p>
									<span><?php echo $prodata['w_design_pct'];?>%</span>
								</p>
							</div>
						</div><!-- companyPbar -->
					</div>
					<div>
						<p>퍼블리싱</p>
						<div  class="companyPbar" >
							<div class="companyPpecent" style="width:<?php echo $prodata['w_publishing_pct'];?>%; background:#00a65a;">
								<p>
									<span><?php echo $prodata['w_publishing_pct'];?>%</span>
								</p>
							</div>
						</div><!-- companyPbar -->
					</div>
					<div>
						<p>개발</p>
						<div  class="companyPbar" >
							<div class="companyPpecent" style="width:<?php echo $prodata['w_develop_pct'];?>%; background:#f39c12;">
								<p>
									<span><?php echo $prodata['w_develop_pct'];?>%</span>
								</p>
							</div>
						</div><!-- companyPbar -->
					</div>
				</div>
				<div>

					<h3>수정 요청 목록</h3>
					<div class="btn_client ">
						<a href="{MARI_HOME_URL}/?cms=<?php echo $cms;?>&gr_id=<?php echo $gr_id;?>&table=<?php echo $table;?>&subject=수정요청&skin=admin_modified">목록 바로가기</a>
					</div>



				   <div class="sBox03">
									<table class="sBox03T1">
								   <colgroup>
									   <col style="width:auto; ">
									   <col style="width:auto; ">
									   <col style="width:300px; ">
									   <col style="width:auto; ">
									   <col style="width:auto; ">
									   <col style="width:auto; ">
									   <col style="width:auto; ">
									</colgroup>
								
								<thead>
									<tr>
										   <th>번호</th>
										   <!--<th>회사명</th>-->
										   <th>분류</th>
										   <th>제목</th>
										   <th>접수일</th>
										   <th>처리예정일</th>
										   <th>담당자</th>
										   <!--<th>긴급</th>-->
										   <th>상태</th>
									 </tr>
								 
								</thead>
								<tbody>
								<?php 
								for ($i=0;  $list=sql_fetch_array($result); $i++){
									$sql = "select gr_subject from  mari_board_group where gr_id='$bbs_config[gr_id]'";
									$group_name = sql_fetch($sql, false);
									$num=$i+1;
									/*뎃글수*/
									$sql = " select count(*) as cnt from mari_comment where w_id='$list[w_id]' and m_id='$mysv[sale_code]' and w_table='$list[w_table]' and co_view='Y'";
									$cocnt = sql_fetch($sql);
									
									$cotop= $cocnt['cnt'];
									/*가장최근 뎃글의 완료여부가져옴*/
									$sql = " select * from mari_comment where w_id='$list[w_id]' and m_id='$mysv[sale_code]' and w_table='$list[w_table]' order by co_datetime desc";
									$useck = sql_fetch($sql);

									if(substr($useck['datepro'],0,10)=='0000-00-00' || $useck['datepro']==""){
										$date_pro = "미정";
									}else{
										$date_pro = substr($useck['datepro'],0,10);
									}
								?>
									<!--<tr class="<?php if(!$cotop){?><?php }else{?>recently02<?php }?>">-->
										<tr class="<?php if(!$cotop){?><?php }else{?><?php }?>">
										<!--접수:background:##ee515e; 완료:background:#e67e22; 진행중: -->
									   <td><?php echo $list['w_id'];?></td>
									   <!--<td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>&skin=admin_modified"><?php echo $list['w_company_name'];?></a></td>-->
									   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>&skin=admin_modified"><!--<?php echo $group_name['gr_subject'];?>--><?php echo $list['w_catecode'];?></a></td>
									   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>&skin=admin_modified">
									  <!-- [<?php echo $list['w_catecode'];?>]-->
										<?php if(!$bbs_config[bo_subject_len]){?>
											<?php echo $list['w_subject'];?><?php if($cotop){?><b>(<?php echo number_format($cotop);?>)</b><?php }?>
										<?php }else{?>
											<?=cut_str(strip_tags($list['w_subject']),$bbs_config[bo_subject_len],"…")?><?php if($cotop){?><b>(<?php echo number_format($cotop);?>)<?php }?></b>
										<?php }?>
									   </a></td>
									   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>&skin=admin_modified"><?php echo substr($list['w_datetime'],0,10); ?></a></td>
									   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>&skin=admin_modified"><!--<?php echo $useck['datepro']?''.substr($useck[datepro],0,10).'':'미정';?>--><?php echo $date_pro;?></a></td>
									   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>&skin=admin_modified"><?php echo $list['w_name'];?></a></td>
									   <!--<td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>&skin=admin_modified">O</a></td>-->
									   <td><a href="{MARI_HOME_URL}/?cms=cs_bbs_view&type=view&table=<?php echo $table; ?>&subject=<?php echo $subject;?>&id=<?php echo $list[w_id]; ?>&all=<?php echo $all;?>&skin=admin_modified"> <?php if($list['w_projectstatus']=="W"){?><p class="colorstatus1" style="background:#f39c12;">접수</p><?php }else if($list['w_projectstatus']=="C"){?><p  class="colorstatus1" style="background:#009abf;">완료</p><?php }else if($list['w_projectstatus']=="P"){?><p  class="colorstatus1" style="background:#00a65a">진행중</p><?php }else if($list['w_projectstatus']=="R"){?><p  class="colorstatus1" style="background:#dd4b39;">재문의</p><?php }else if($list['w_projectstatus']=="A"){?><p  class="colorstatus1" style="background:#143fa1; font-size:12px;">담당자배정</p><?php }?>
									   <!--<p class="colorstatus1" style="background:#f39c12;">접수</p>
									  
									      <p  class="colorstatus1" style="background:#009abf;">완료</p> 
										    <p  class="colorstatus1" style="background:#dd4b39;">재문의</p> --></a></td>

									</tr>
								<?php
								}
								if ($i == 0)
									echo "<tr><td colspan=7>접수된 내용이 없습니다.</td></tr>";
								?>


								 </tbody>
						   </table>
                     
						 <div class="company-page3">
			<!--패이징--><?php echo get_paging($bbs_config['bo_page_rows'], $page, $total_page, '?cms='.$cms.'&group='.$gr_id.'&table='.$table.'&subject='.$subject.'&all='.$all.'&skin='.$skin.''.$qstr.'&amp;page='); ?>
						 <!--
							<ul class="pagination1" >
								<li><a href="?page=1"><span >«</span></a></li>
								<li class="active"><a href="?page=1">1</a></li>
								<li ><a href="?page=2">2</a></li>
								<li><a href="?page=3">3</a></li>
								<li><a href="?page=3"><span >»</span></a></li>
							</ul>
							-->
						   </div><!--company-page-->
				  
				   </div><!-- sBox03 -->

				</div>
			</section>
<?php }?>
		</div><!-- client_containerinner -->



	</div><!-- client_container -->
</div><!-- /wrapper -->

<script>


	$(function() {
		$('#datepicker1').datepicker({
			changeMonth: true,
			changeYear: true,
			yearRange: '2009:2020',
		    showOn: "button", 
            buttonImage:"{MARI_ADMINSKIN_URL}/img/mo.png",
            buttonImageOnly:true

		});		
	});
	
	

</script>

{# s_footer}<!--하단-->






