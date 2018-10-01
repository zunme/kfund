var table;
var table2;
function sms_cancel(span){
  var m_no= $(span).data('mno');
  $.ajax({
    type : 'GET',
    url : 'adm/issmsmem',
    dataType : 'json',
    data : {
    "m_no" : m_no
    },
    success : function(result) {
      if( result.code != 200){
        alert(result.msg);
        return;
      }
      if( confirm(result.msg) ){

        $.ajax({
          type : 'POST',
          url : 'adm/smsmemchange',
          dataType : 'json',
          data : result.data,
          success : function(result2) {
            if( result2.code != 200 ){
              alert( result2.msg);return;
            }

            $.ajax({
              type : 'GET',
              url : 'adm/issmsmem',
              dataType : 'json',
              data : {
              "m_no" : m_no
              },
              success : function(result3) {
                if( result2.code != 200 ){
                  $(span).text('');
                }else $(span).text(result3.data.m_sms);

              }
            });

          }
        });

      }
    }
  });
}
function analfirst(id) {
  $("#bar-example").empty();
  $("#bar-example").text('');
  $("#bar-example2").empty();
  $("#bar-example2").text('');
  $.ajax({
    type : 'POST',
    url : '/api/index.php/adm/firstanal?id='+id,
    dataType : 'json',
    success : function(result) {
      console.log()
      Morris.Bar({
        element: 'bar-example',
        data: result.data,
        xkey: 'y',
        ykeys: ['a', 'b'],
        labels: ['첫투자액', '재투자액']
      });
      Morris.Bar({
        element: 'bar-example2',
        data: result.data2,
        xkey: 'y',
        ykeys: ['a', 'b'],
        labels: ['첫투자자', '재투자자']
      });
    }
  });
}
function changepwd(i){
  var input =$(i).prev();
  if(confirm ( $(input).data('id') +'의 패스워드를 "'+$(input).val()+'" 으로 변경하시겠습니까?') ) {
    $.ajax({
      type : 'POST',
      url : 'adm/changepwd',
      dataType : 'json',
      data : {
      "m_id" : $(input).data('id'),
      "newpwd":$(input).val()
      },
      success : function(result) {
        alert(result.msg);
      }
    });
  }
}
function openNewWindow(userid) {
  var specs = "left=10,top=10,width=720,height=800";
  specs += ",toolbar=no,menubar=no,status=no,scrollbars=no,resizable=no";
  window.open('/api/index.php/seyfertinfo/info?mid='+userid, "SeyferInfoView", specs);
}
function trformat ( d ) {
    // `d` is the original data object for the row
    return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">'+
    '<tr>'+'<td>ID NO:</td>'+'<td>'+d.i_id+'</td>'+'</tr>'+
    '<tr>'+'<td>MEM ID:</td>'+'<td><a href="javascript:;"  onClick="searchuser(\''+d.m_id+'\')">'+d.m_id+'</a></td>'+'</tr>'+
    '<tr>'+'<td>대출금액:</td>'+'<td>'+d.i_loan_pay+'</td>'+'</tr>'+
    '<tr>'+'<td>개월:</td>'+'<td>'+d.months+'개월</td>'+'</tr>'+
    '<tr>'+'<td>이율:</td>'+'<td>'+d.i_year_plus+'%</td>'+'</tr>'+
    '<tr>'+'<td>수납처리:</td>'+'<td><span class="btn btn-primary" onClick="sunapmodal('+d.i_id+')">수납하기</span></td>'+'</tr>'+
    '</table>';
}
function trformat2 ( d ) {
    // `d` is the original data object for the row
    return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;" class="innertable">'+
    '<tr>'+'<td>계좌:</td>'+'<td>'+d.m_my_bankacc+'('+d.m_my_bankcode+')</td>'+'</tr>'+
    '<tr>'+'<td>가상계좌:</td>'+'<td>'+d.s_accntNo+'('+d.s_bnkCd+')</td>'+'</tr>'+
    '<tr>'+'<td>투자액:</td>'+'<td  align="right">'+(d.payed).numberformat()+'원</td>'+'</tr>'+
    '<tr>'+'<td>한도:</td>'+'<td>'+d.maximum.numberformat()+'원</td>'+'</tr>'+
    '<tr>'+'<td>남은한도:</td>'+'<td>'+(d.maximum-d.payed).numberformat()+'원</td>'+'</tr>'+
    '<tr>'+'<td>비밀번호변경:</td>'+'<td><input type="text" data-id="'+d.m_id+'"><i class="fa fa-check-circle" onClick="changepwd(this);" style="color:red;cursor:pointer"></i></td>'+'</tr>'+
    '<tr>'+'<td>등급변경:</td>'+'<td style="color:blue;cursor:pointer" onClick="changeMemberLevel(\''+d.m_id+'\')">'+d.memlabel+'</td>'+'</tr>'+
    '<tr>'+'<td>파일:</td>'+'<td>'
     +'종합소득신고서-전년도 (사업자등록증) : '+ ( d.m_declaration_01 !='' ? '<a href="/pnpinvest/data/file/member/'+d.m_declaration_01 + '" target="_blank">등록</a>'  :"미등록" )
     +'<br> 종합소득확정신고서 (사업자신분증) : '+ ( d.m_declaration_02 !='' ? '<a href="/pnpinvest/data/file/member/'+d.m_declaration_02 + '" target="_blank">등록</a>'  :"미등록" )
     +'<br> 전문투자자확인 (법인통장사본) : '+ ( d.m_bill !='' ? '<a href="/pnpinvest/data/file/member/'+d.m_bill + '" target="_blank">등록</a>'  :"미등록" )
     +'<br> 근로소득원천징수연수증 (법인통장사본) : '+ ( d.m_bill !='' ? '<a href="/pnpinvest/data/file/member/'+d.m_bill + '" target="_blank">등록</a>'  :"미등록" )
     +'</td>'+'</tr>'+
    '</table>';
}
function changeMemberLevel(memid){
   dynamicmodal('/api/index.php/adm/changelevel?user='+memid, '등급변경 ['+memid+']');
}
function viewinv(id){
  $.ajax({
    type : 'GET',
    url : 'adm/investlist',
    dataType : 'html',
    data : {
    "i_id" : id,
    "type":'html'
    },
    success : function(result) {
      $("#myModalBody").empty().html(result);
      $("#myModalLabel").text('투자자목록');

      $("#smodal").modal();
    }
  });
}
function completed() {
  if($('input[name=emoneycheck]:checked').val() !='Y') return;
  $("#datatable2 tbody tr td span.seyfertemoney").each ( function (){
    var span = this;
    $.ajax ({
  		type: "POST",
  		url : "/api/index.php/seyfertinfo/lnq",
  		data : {mn:$(span).data('id')},
  		dataType : 'json' ,
  		success: function(data) {
  			if(data.code === 200 ) {
  				$(span).html(data.data.amount.numberformat() + '원확인됨');
  			}else {
  				$(span).html("Error("+ data.msg+")");
  			}
  		}
  	});
  });
}
function seyfertrefresh(refresh){
  var span = $(refresh).prev();
  $.ajax ({
    type: "POST",
    url : "/api/index.php/seyfertinfo/lnq",
    data : {mn:$(span).data('id')},
    dataType : 'json' ,
    success: function(data) {
      if(data.code === 200 ) {
        $(span).html(data.data.amount.numberformat() + '원확인됨');
      }else {
        $(span).html("Error("+ data.msg+")");
      }
    }
  });
}
function searchuser(user){
  $("#datatable2_filter input[type='search']").val(user);
   $('#datatable2').dataTable().fnFilter(user);
  $('#smodal').modal('hide');
  $('#dyModal').modal('hide');
}
function fnchangedSearch(){
  $('#datatable2').dataTable().fnFilter($("#datatable2_filter input[type='search']").val());
}
function authmem(span){
	if( confirm('확인완료로 변경하시겠습니까?') ){
		$.ajax ({
			type: "POST",
			url : "/api/index.php/adm/authmem",
			data : {mno: $(span).data('mno') },
			dataType : 'json' ,
			success: function(data) {
				if(data.code=="OK"){
					$(span).parent().text('Y');
					alert('확인완료');
				}else {
					alert (data.msg);
				}
			}
		});
	}
}
function authmem_cancel(span){
	if( confirm('확인을 취소하시겠습니까?') ){
		$.ajax ({
			type: "POST",
			url : "/api/index.php/adm/authmemcancel",
			data : {mno: $(span).data('mno') },
			dataType : 'json' ,
			success: function(data) {
				if(data.code=="OK"){
					$(span).parent().text('N');
					alert('변경완료');
				}else {
					alert (data.msg);
				}
			}
		});
	}
}
function resetuse(td){
  if( confirm('['+$(td).closest('tr').children("td:nth-child(2)").text() + ']\n지급완료를 지급대기로 초기화 하시겠습니까?')){
    var idx = $(td).data('id');
    $.ajax ({
			type: "POST",
			url : "/api/index.php/adm/resetuse",
			data : {loanid: $(td).data('id') },
			dataType : 'json' ,
			success: function(data) {
				if(data.code=="OK"){
					$(td).text('N');
					alert('변경완료');
				}else {
					alert (data.msg);
				}
			}
		});
  }
}
function viewOver(lid){
	$.get()
	$.ajax({
	  url: '/api/index.php/cmsloanlist/viewover?loanid='+lid,
	  success: function (data){
			alert(data.msg.replace(/\\n/g,"\n"))
		},
	  dataType: 'json'
	});
}
$(document).ready(function() {
     table2 = $('#datatable2').DataTable( {
     "processing": true,
     "serverSide": true,
     "scrollX": true,
     "lengthMenu": [ 5, 10],
     "ajax": {
         "url": "/api/index.php/adm/userlist",
         "type": "GET",
         "data": function ( d ) {
                  return $.extend( {}, d, {
                    "isnotauthed": $('input[name=isnotauthed]:checked').val(),
                    "searchlevel": $('#searchlevel option:selected').val()
                  } );
        }
     },
     "drawCallback": completed,
     "columns": [

         { "data": "m_no","className":      'details-control' ,"defaultContent": '',
         "render": function (){return '';}
          },
         { "data": "m_id" ,"className":'memlogin',
         "render": function ( data) { return '<i class="fa fa-user" data-id="'+ data +'"></i> '+data + '<i class="fa fa-comment" data-id="'+ data +'"></i>' +'<i class="fa  fa-info-circle" data-id="'+ data +'"></i>' +'<i class="90days" data-id="'+ data +'" style="padding-left:5px;">선인증</i> <i class="fa fa-folder-open" style="padding-left:10px" href="/api/admmember/memberdoc?mid='+ encodeURI(data) +'" onclick="izimodalopen(event)"></i>' }
          },
         { "data": "m_name" },
         { "data": "m_hp" },
         { "data": "virtualacc",
          "orderable": false ,
          "render": function ( data, type, row, meta ) {
                 if(data=='Y') return '<a class="linked_class" onClick="openNewWindow(\''+row.m_id+'\')">가상계좌</a><br><a class="linked_class" onclick="openSsyWindow2(\''+row.m_id+'\')" >잔액변동</a>&nbsp/&nbsp<a class="linked_class" onclick="openSsyWindow(\''+row.m_id+'\',\'src\')" >보낸내역</a>&nbsp/&nbsp<a class="linked_class" onclick="openSsyWindow(\''+row.m_id+'\',\'dst\')" >받은내역</a>';
                 else return data;
               }
         },
         { "data": "m_verifyaccountuse","orderable": false },
         { "data": "m_emoney",
            "render": function ( data, type, row,meta) {
              if(row.virtualacc=='Y') return data + '<br><span class="seyfertemoney" data-id="'+row.m_id+'"></span><i class="fa fa-refresh seyfertemoneyrefresh" onClick="seyfertrefresh(this)"></i>';
              else return data;
            }
          },
          { "data": "payed",
             "render": function ( data, type, row,meta) {
               return '<span class="payavail" data-id="'+row.m_id+'"></span>'+(row.maximum-row.payed).numberformat()+'</span>';
             }
           },
         { "data": "memlabel" ,"orderable": false,},
         { "data": "m_referee" ,"orderable": false,
            "render": function ( data, type, row,meta) {
              return data +'<br>['+row.invlist+']';
            }
          },
          { "data": "m_sms" ,"orderable": false,
             "render": function ( data, type, row,meta) {
               if(data == 1) return '<span class="smsmember nosms" onClick="sms_cancel(this)"  data-mno="'+row.m_no+'" >Y<span>';
               else return '<span class="smsmember smsget" onClick="sms_cancel(this)" data-mno="'+row.m_no+'" >N<span>';
             }
          },
         { "data": "authed" ,"orderable": false,
            "render": function ( data, type, row,meta) {
              if(data=='Y') return '<span class="memauthcancel" onClick="authmem_cancel(this)"  data-mno="'+row.m_no+'" >'+data+'<span>';
              else return '<span class="memauth" onClick="authmem(this)" data-mno="'+row.m_no+'" >'+data+'<span>';
            }
         }
     ],
     "order": [[0, 'desc']]
   });
    table = $('#datatable1').DataTable( {
      "processing": true,
      "serverSide": true,
      "scrollX": true,
      "lengthMenu": [ 5, 10],
      "ajax": {
          "url": "/api/index.php/adm/loanlist",
          "type": "GET"
      },
      "columns": [
          { "data": "i_id" ,"className":      'details-control',"render": function (){return '';}},
          { "data": "i_subject","render": function (data, type, row, meta){ return '<span class="fa rightpadding '+row.sameowner+' triggerModal"  href="/api/index.php/cmsloanlist/getsameowner?lid='+row.i_id+'" onClick="izimodalopen(event)"></span>'+data +'<a href="javascript:;" title="첫투자/재투자" onclick="analfirst( '+row.i_id+' )" style="padding-left:6px;"><i class="fa fa-bar-chart"></i></a><i class="fa fa-stack-overflow" aria-hidden="true" style="padding-left:10px" onclick="viewOver('+row.i_id+')"></i>'} },
          { "data": "i_repay" ,"render": function (data, type, row, meta){ if(data=='일만기일시상환') return '<span class="viewinterest" data-id="'+row.i_id+'">일만기일시</span>';else return data}},
          { "data": "i_look", "render": function (data, type, row, meta){return '<span class="details-inv" data-id="'+row.i_id+'" onClick="viewinv('+row.i_id+')">'+data+'</span>'} },
          { "data": "i_loanexecutiondate2" },
          { "data": "i_reimbursement_date" },
          { "data": "i_pendingsf_use" ,"render": function (data, type, row, meta){ if(data=='Y') return '<span class="pendingsf_use" data-id="'+row.i_id+'" onClick="resetuse(this)">Y</span>';else return data} }
      ],
      "order": [[0, 'desc']]
    });

    $('#datatable1').dataTable().fnFilterOnReturn();
    $('#datatable2').dataTable().fnFilterOnReturn();
    $('#datatable2_filter').css('width','100%');
    $('#datatable2_filter').children("label").append("<span class='btn btn-primary' style='margin-bottom:0' onClick='fnchangedSearch()'>검색</span>");
    $('#datatable1 tbody').on('click', 'td.details-control', function () {
        var tr = $(this).closest('tr');
        var row = table.row( tr );

        if ( row.child.isShown() ) {
            // This row is already open - close it
            row.child.hide();
            tr.removeClass('shown');
        }
        else {
            // Open this row
            row.child( trformat(row.data()) ).show();
            tr.addClass('shown');
        }
    } );
    $('#datatable2 tbody').on('click', 'td.details-control', function () {
        var tr = $(this).closest('tr');
        var row = table2.row( tr );

        if ( row.child.isShown() ) {
            // This row is already open - close it
            row.child.hide();
            tr.removeClass('shown');
        }
        else {
            // Open this row
            row.child( trformat2(row.data()) ).show();
            tr.addClass('shown');
        }
    } );
    $('#datatable1 tbody').on('click', 'td span.viewinterest', function () {
      if( $(this).text() != '일만기일시' ) {
        return;
      }else {
        dynamicmodal('/api/index.php/adm/ilmangitable?loanid='+$(this).data('id'), '예상이자테이블');
      }
    });
    $('#datatable2 tbody').on('click', 'td.memlogin i.fa-user', function () {
       var memid = $(this).data('id');
       if( confirm(memid+'로 로긴하시겠습니까?') ) {
         window.open('/api/index.php/adm/memlogin?mid='+memid);
       }
    });
    $('#datatable2 tbody').on('click', 'td.memlogin i.fa-comment', function () {
       var memid = $(this).data('id');
       dynamicmodal('/api/index.php/adm/userlog?user='+memid, 'LOG ['+memid+']');
    });
    $('#datatable2 tbody').on('click', 'td.memlogin i.fa-info-circle', function () {
       var memid = $(this).data('id');
       dynamicmodal('/api/index.php/adm/useremoneylog?user='+memid, '입출금내역 ['+memid+']');
    });
    $('#datatable2 tbody').on('click', 'td.memlogin i.90days', function () {
      var span = this;
       $.ajax({
         type : 'GET',
         url : '/api/index.php/seyfertinfo/preauthcheck',
         dataType : 'html',
         data : {
         "mid" : $(span).data('id')
         },
         success : function(result) {
           $(span).empty().html(result);
         }
       });

    });
    $('#adminlogin').on('click', function () {
       var memid = $(this).data('id');
       if( confirm(memid+'로 로긴하시겠습니까?') ) {
         window.open('/api/index.php/adm/memlogin?adm=Y&mid='+memid);
       }
    });
    $('.details-inv').on('click', function () {
      //var id = $(this).closest('tr').children('td:nth-child(2)').text();
      var id = $(this).data('id');
      $.ajax({
        type : 'GET',
        url : 'adm/investlist',
        dataType : 'html',
        data : {
        "i_id" : id,
        "type":'html'
        },
        success : function(result) {
          $("#myModalBody").empty().html(result);
          $("#myModalLabel").text('투자자목록');

          $("#smodal").modal();
        }
      });
    });
  });
