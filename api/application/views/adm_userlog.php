<style>
.reserved {color:red}
.reserv-end {color:blue}
</style>
<form class="form" role="form" id="dyModamForm">
  <div class="row">
    <div class='col-sm-4'>
      <label>선택</label>
      <div class="form-group">
        <select class="input-sm" name="code">
          <?php foreach ($reservcode as $idx=>$val) {?>
            <option value="<?php echo $idx;?>"><?php echo $val;?></option>
          <?php }?>
        </select>
      </div>
    </div>
      <div class='col-sm-4'>
        <label>TODO</label>
        <div class="form-group">
          <input id="isnotauthed" type="checkbox" name="todo" value="Y" onclick="changeuserlogcode()">
        </div>
      </div>
      <div class='col-sm-4'>
        <label>알림예약</label>
          <div class="form-group">
              <div class='input-group date' id='datetimepicker1'>
                  <input type='text' name=reserv class="form-control" onChange="changecode()"/>
                  <span class="input-group-addon">
                      <span class="glyphicon glyphicon-calendar"></span>
                  </span>
              </div>
          </div>
      </div>
      <script type="text/javascript">
          $(function () {
              $('#datetimepicker1').datetimepicker({format: 'YYYY-MM-DD HH:mm'});
          });
      </script>
  </div>
  <div class="row">
    <div class='col-sm-12'>
      <input type="hidden" name="m_id" value="<?php echo $m_id?>">
      <label for="message">기록</label>
      <textarea id="message" required="required" class="form-control" name="message"></textarea>
    </div>
  </div>
  <div style="text-align:center;margin-top:20px;">
    <span class="btn btn-primary" onclick="checkmsg()">저장하기</span>
  </div>
</form>
<br>
<div class="x_panel">
  <div class="x_title">
     <h2>LOG<small><?php echo $m_id?></small></h2>
     <ul class="nav navbar-right panel_toolbox">
       <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
       </li>
     </ul>
     <div class="clearfix"></div>
   </div>
  <div class="row" id="userlogbox">
    <div class="col-sm-12 mail_list_column">
      <?php foreach($logs as $log) { ?>
      <a href="#">
        <div class="mail_list">
          <div class="left">
            <i class="fa fa-circle<?php echo ' '.$log['resvclass']?>"></i> <i class="fa fa-edit"></i>
          </div>
          <div class="right">
            <h3><?php echo $this->basic->logtitle($log['code'],$log['reserv']);?> <?php $this->nowdate->format('YmdHis')?><small style="padding-left:10px;"> by <?php echo $log['writer']?></small><small><?php echo $log['reg_date']?></small></h3>
            <p><?php echo $log['msg']?></p>
          </div>
        </div>
      </a>
    <?php }  ?>
    </div>
  </div>
</div>
<script type="text/javascript">
  function changeuserlogcode() {
    var code ='';
    if( $("input[name='reserv']").val() != '') code = 'R001';
    if( $("input[name='todo']:checked").val() =='Y')  code = 'R002';
    if(code != '' ) $("select[name='code']" ).val(code).prop("selected", true);
    else {
      if( ['R'].includes( $("select[name='code']").val().charAt(0) ) ) $("select[name='code']" ).val('L001').prop("selected", true);
    }
  }
  function checkmsg() {
    changeuserlogcode();
    $.ajax({
      type : 'POST',
      url : 'adm/userlogwrite',
      dataType : 'json',
      data : $("#dyModamForm").serialize(),
      success : function(result) {
        if( result.code==200) $('#dyModal').modal('hide');
        alert(result.msg);
      }
    });
  }
    $(function () {
        $('#datetimepicker1').datetimepicker();
    });
</script>
