<form id=dyModamForm>
<input type="hidden" name="m_id" value="<?php echo $meminfo['m_id']?>">
<div class="row">
  <div class="form-group" >
    <label class="control-label col-md-3 col-sm-3 col-xs-12">등급</label>
    <div class="col-md-9 col-sm-9 col-xs-12">
      <select name="level" class="select2_group form-control">
        <optgroup label="변경 할 등급을 선택해주세요">
          <?php foreach($levellist as $idx=>$val){ ?>
            <option value="<?php echo $idx?>" <?php echo ( $idx == $meminfo['m_signpurpose']&& $meminfo['m_level']=='2') ? 'selected' : (($idx=='level_morethan_2' && $meminfo['m_level']=='3')? 'selected': '') ;     ?> ><?php echo $val?></option>
          <?php }?>
        </optgroup>
      </select>
    </div>
  </div>
</div>
<div class="row" style="margin:30px 10px;">
  <div class="form-group" >
    <div class="col-md-12 col-sm-12 col-xs-12" >
      <span class="btn btn-round btn-danger pull-right" onClick="changelevel()">저장하기</span>
    </div>
  </div>
</div>
</form>
<script>
  function changelevel() {
    $.ajax({
      type : 'POST',
      url : 'adm/changelevelprc',
      dataType : 'json',
      data : $("#dyModamForm").serialize(),
      success : function(result) {
        if( result.code==200) {
          table2.ajax.reload();
          $('#dyModal').modal('hide');
        }
        alert(result.msg);
      }
    });
  }
</script>
