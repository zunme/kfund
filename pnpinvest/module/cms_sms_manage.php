<?php
  $groupNameIng = array(
        "L"=>array("label"=>'대출회원', 'cnt'=>0 ),
        "I"=>array("label"=>'투자회원', 'cnt'=>0 ),
        "N"=>array("label"=>'일반회원', 'cnt'=>0 )
  );
  $sql = "
    select
    g.grptype , count(1) cnt
    from view_sms_grouping g
    group by g.grptype
  ";
  $newgrpqry = sql_query($sql);
  while ($newgrpqryres = sql_fetch_array($newgrpqry)){
    $groupNameIng[ $newgrpqryres['grptype'] ]['cnt'] = $newgrpqryres['cnt'];
  }
?>
