<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>

{#header_sub}

<div id="container">
	<div id="sub_content">
		<div class="mypage">
			<div class="mypage_inner">

				
				<div class="dashboard">
					<div class="dashboard_side">
						<div class="my_profile">
							<img src="{MARI_HOMESKIN_URL}/img/img_profile.png" alt=""/>
							<a href="{MARI_HOME_URL}/?mode=mypage_basic" class="info_modify">정보수정</a>
							<p class="txt_c"><strong><?php if($user[m_level] >= 3){?><?php echo $user['m_company_name'];?><?php }else{?><?php echo $user['m_name'];?><?php }?></strong>님 환영합니다!</p>
							<p class="txt_c"><?php echo $user['m_id'];?></p>
							<strong class="mt20"><span class="emoney_title">예치금</span><span class=""><?php echo number_format($user[m_emoney]) ?>원</span></strong>
							<!---->
						</div>

						<!--마이페이지 헤더-->
						{# mypage_header}
					</div><!--dash_side--e-->

					<div class="dashboard_content">
						<div class="dashboard_my_info">
							<h3><span>예치금 관리</span>
								<ul>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_balance" >입/출금 관리</a></li>
									<li>|</li>
									<li><a href="{MARI_HOME_URL}/?mode=mypage_emoney" class="info_current">내역</a></li>
								</ul>
							</h3>
							<div class="dashboard_emoney">
								<h3><img src="{MARI_HOMESKIN_URL}/img/icon_dashboard.png" alt="" class="mr10"/> 입/출금 내역</h3>
								<span>예치금의 입/출금 내역을 확인하실 수 있습니다.</span>
								<div>
									<table class="">
										<colgroup>
											<col width="100px">
											<col width="400px">
											<col width="170px">
											<col width="170px">
										</colgroup>
										<thead>
											<tr>
												<th>일시</th>
												<th>내용</th>
												<th>금액</th>
												<th class="last">잔액</th>
											</tr>
										</thead>
									<?php
										$sql = " select count(*) as cnt from mari_emoney where m_id='$user[m_id]'";
										$emoney_cnt = sql_fetch($sql);
										$emoney_total  = $emoney_cnt['cnt'];
										$rows = 11;
										$total_page = ceil($emoney_total / $rows);
										if($page < 1) $page = 1;
										$from_record = ($page - 1) * $rows; 

										$sql = " select * from mari_emoney where m_id='$user[m_id]'  order by p_id desc limit $from_record, $rows";
										$emoney = sql_query($sql);
										for($i=0; $row = sql_fetch_array($emoney); $i++){
									?>
										<tbody>
											<tr>
												<td><?php echo substr($row[p_datetime],0,10);?></td>
												<td><?php echo $row[p_content];?></td>
												<td><?php echo number_format($row[p_emoney]);?>원</td>
												<td><?php echo number_format($row[p_top_emoney]);?>원</td>
											</tr>
										</tbody>
									<?php }if($i==0){ ?>
										<td colspan="5">현재 내역이 없습니다.</td>
									<?php }?>
									</table>
							<!--패이징--><?php echo get_paging($config['c_write_pages'], $page, $total_page, '?mode='.$mode.''.$cate_sorting.''.$qstr.'&amp;page='); ?>
						
								</div>
							</div>
						</div>
					</div>
				</div>
			</div><!--//mypage_inner e -->
		</div>
		<!--//mapage e -->
	</div>
	<!--//main_content e -->
</div>
<!--//container e -->
{#footer}