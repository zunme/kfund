<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>scrap</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10,user-scalable=yes">
</head>
<body>
  <table>
    <?php foreach ($list as $row){?>
    <tr>
      <td><?php echo $row['cate']?></td>
      <td><?php echo $row['cname']?></td>
      <td><?php echo $row['name']?></td>
      <td><?php echo $row['postnum']?></td>
      <td><?php echo $row['addr']?></td>
      <td><?php echo $row['tel']?></td>
      <td><?php echo $row['prd']?></td>
    </tr>
  <?php } ?>
    <table>
</body>
</html>
