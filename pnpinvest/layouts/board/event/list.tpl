<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
//include('/var/www/html/pnpinvest/module/mode_bbs_list.php');
//include('/home/pnpinvest/www/pnpinvest/module/mode_bbs_list.php');
include (getcwd().'/module/mode_bbs_list.php');
?>
{# new_header}
<!-- /////////////////////////////// 본문 시작 /////////////////////////////// -->
<style>
	p.paging span{margin-right: 5px;}
</style>
<div id="container" class="sub">
	<!-- Sub title -->
	<h2 class="subtitle"><span class="motion" data-animation="flash">이벤트</span></h2>
	<!-- 게시판 -->
	<div class="board">
		<div class="container">
			<div class="board_wrap">
			<!-- 검색 -->
			<form action="/pnpinvest/" method="GET">
        <input type="hidden" name="mode" value="bbs_list">
        <input type="hidden" name="table" value="event">
				<input type="hidden" name="search" value="<?php echo htmlspecialchars ($_GET['searchtxt'],ENT_QUOTES )?>">
				<div class="board_sch">
					<p class="txt_sch"><input type="text" placeholder="이벤트 검색" name="searchtxt" value="<?php echo htmlspecialchars ($_GET['searchtxt'],ENT_QUOTES )?>"></p>
					<button class="btn_sch" type="submit">검색</button>
				</div>
			</form>
			<!-- 진행중인 이벤트 -->
			<h3>진행중인 이벤트</h3>
			<!-- 게시판 테이블 -->
			<table>
				<caption>진행중인 이벤트</caption>
				<colgroup>
					<col class="no" style="width:8%;">
					<col>
					<col class="pc" style="width:10%;">
					<col class="pc" style="width:10%;">
					<col class="pc" style="width:8%;">
				</colgroup>
				<thead>
					<tr>
						<th><span>번호</span></th>
						<th><span>제목</span></th>
						<th class="pc"><span>작성자</span></th>
						<th class="pc"><span>작성일</span></th>
						<th class="pc"><span>조회수</span></th>
					</tr>
				</thead>
				<tbody id="eventnow">

				</tbody>
			</table>
			<!-- 페이징 -->
			<p class="paging" id="eventnowpage">
			</p>

			<!-- 진행마감 공지사항 -->
			<h3>진행마감 이벤트</h3>
			<!-- 게시판 테이블 -->
			<table>
				<caption>진행마감 공지사항</caption>
				<colgroup>
					<col class="no" style="width:8%;">
					<col>
					<col class="pc" style="width:10%;">
					<col class="pc" style="width:10%;">
					<col class="pc" style="width:8%;">
				</colgroup>
				<thead>
					<tr>
						<th><span>번호</span></th>
						<th><span>제목</span></th>
						<th class="pc"><span>작성자</span></th>
						<th class="pc"><span>작성일</span></th>
						<th class="pc"><span>조회수</span></th>
					</tr>
				</thead>
				<tbody id="eventend">
				</tbody>
			</table>
			<!-- 페이징 -->
			<p class="paging" id="eventendpage">
			</p>
		</div>
		</div>
	</div>
</div>
<script>
function getboard(url,id){
  $.ajax({
   type : 'GET',
   url : url,
   dataType : 'json',
   success : function(result) {
     $("#"+id+"page").html(result.page);
		 $("#"+id).empty();
		 $.each(result.list, function (ind, row) {
			 $("#"+id).append( "<tr><td>" + row.w_id + "</td><td class='tl'><a href='/pnpinvest/?mode=bbs_view&type=view&table=<?php echo $table?>&id="+row.w_id+"'>"+row.w_subject+"</a></td><td class='pc'>관리자</td><td class='pc'>"+row.w_datetime+"</td><td class='pc'>"+row.w_hit+"</td></tr>");
		 });
   }
  });
}
function pagechange(link, id){
	getboard( link, id );
	console.log(id);
}

$(document).ready(function () {
  getboard("/api/index.php/boardapi/boardlist?table=event&catenot=마감&target=eventnow&search="+$("input[name='search']").val(),'eventnow' );
	getboard("/api/index.php/boardapi/boardlist?table=event&cate=마감&target=eventend&search="+$("input[name='search']").val(),'eventend' );
});
</script>
<!-- /////////////////////////////// 본문 끝 /////////////////////////////// -->
{# new_footer}
