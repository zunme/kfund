<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 마이페이지
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->
{# header}<!--상단-->
<section id="container">
		<section id="sub_content">
			<div class="mypage_wrap">
			<?php
			if($my=="loanstatus"){
			/*대출신청정보*/
			?>
			<?php
			}else{
			?>	
				<div class="container">
					<h3 class="s_title1">e머니 내역</h3>
					<div class="my_inner2">
						<table class="type3">
							<colgroup>
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
							</colgroup>
							<thead>
								<tr>
									<th>지급일시</th>
									<th>내용</th>
									<th>e머니</th>
									<th>잔액</th>
								</tr>
							</thead>
							<tbody>
							<?php
							for ($i=0; $row=sql_fetch_array($emoney); $i++) {
							$sql = "select  * from  mari_member where m_id='$row[m_id]'";
							$em = sql_fetch($sql, false);
							?>

								<tr>
									<td><?php echo substr($row['p_datetime'],0,10); ?></td>
									<td><?php echo $row['p_content']; ?></td>
									<td><?php echo number_format($row[p_emoney]) ?>원</td>
									<td><?php echo number_format($row[p_top_emoney]) ?>원</td>
								</tr>


							<?php
							}
							if($i == 0)
								echo "<tr><td colspan=\"4\">e-머니 내역이 없습니다.</td></tr>";
							?>	
							</tbody>
						</table>
					</div><!-- /my_inner2 -->
				</div>
			<?php }?>	
			</div><!-- /mypage_wrap -->
		</section><!-- /sub_content -->
	</section><!-- /container -->
{# footer}<!--하단-->