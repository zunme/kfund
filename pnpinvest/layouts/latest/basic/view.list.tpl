<?php
include(MARI_VIEW_PATH.'/Common_select_class.php');
?>
<!--
┏━━━━━━━━━━━━━━━━━━━━━━━┓
▶ 최신게시글
┗━━━━━━━━━━━━━━━━━━━━━━━┛
-->

    <ul class="news_lst">
    <?php for ($i=0; $i<count($list); $i++) {  ?>
        <li>
            <?php
            echo "<a href=\"".MARI_HOME_URL."/?mode=bbs_view&type=view&table=".$list[$i]['w_table']."&subject=".$list[$i]['w_subject']."&id=".$list[$i]['w_id']."\">";
            if ($list[$i]['w_notice']=="Y")
                echo "<strong>".$list[$i]['w_subject']."</strong>";
            else
                echo $list[$i]['w_subject'];
            echo "</a>";
             ?>
        </li>
    <?php }  ?>
    <?php if (count($list) == 0) { ?>
    <li>게시물이 없습니다.</li>
    <?php }  ?>
    </ul>