<?php
$lastidx = 0;
      if ( count($reservlist) > 0 ) {
        foreach($reservlist as $erow){
          $lastidx = ( $lastidx < $erow['idx'] ) ? $erow['idx']: $lastidx;
?>
<li data-idx="<?php echo $erow['idx']?>">
  <a>
    <!--span class="image"><img src="images/img.jpg" alt="Profile Image"></span-->
    <span>
      <span style="color: #008EFC;cursor: pointer;" onClick="searchsetuser('<?php echo $erow['m_id']?>')"><?php echo $erow['m_id']?></span>
      <span class="time"><?php echo $erow['reserv']?></span>
    </span>
    <span class="message">
      <span ><?php echo $erow['msg']?></span>
    </span>
  </a>
</li>
<?php }
}?>
@@val=<?php echo $lastidx?>@@val=<?php echo count($reservlist)?>
