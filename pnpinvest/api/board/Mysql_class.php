<?
require_once 'MDB2.php';

  define(DBTYPE, "mysql");
  define(DBHOST, "mdb99");
  define(DBUSER, "playauto");
  define(DBPASS, "ahffkdy;;");
  define(DBNAME, "ECHost");

/*
-------------------------------------------------
※  기본 적인 mysql 접속, query , execute , 종료, 트랜젝션 기능
pear 기반으로 실행 되기 때문에 필요할때마다
pear 에서 제공되는 메소드들을 추가해서 사용하면됨.
-------------------------------------------------
*/
class Mysql{

  var $inst_mdb2;  // MDB2 인스턴스
  var $rownum; // fetch시 레코드갯수
  var $colnum;  // fetch시 필드   갯수

//--------------------------------
// 생성자
//--------------------------------
function mysql(){

  $argc = func_num_args();
  $argv = func_get_args();

  if ($argc == 0){
    return true;
  }
  else if ($argc == 2) {
    $inifile = $argv[0];
    $dbname  = $argv[1];
    $ini = @parse_ini_file($inifile, true);
    $hostname = $ini[$dbname][hostname];
    $user     = $ini[$dbname][user];
    $passwd   = $ini[$dbname][passwd];
  }
  else if ($argc == 5) {
    $db = $argv[0];
    $hostname = $argv[1];
    $user     = $argv[2];
    $passwd   = $argv[3];
    $dbname   = $argv[4];
  }
  else {return false;}

  $dsn = array(
  'phptype' => $db,
  'username' => $user,
  'password' => $passwd,
  'hostspec' => $hostname,
  'database' => $dbname);

  // 접속은 완료
  $mdb2 =& MDB2::connect($dsn);
  if(PEAR::isError($mdb2)){die($mdb2->getMessage());}

  // 인스턴스 글로벌화
  $this->inst_mdb2	 =	$mdb2;

// function - End
}

//--------------------------------
//  레코드갯수 세팅 (딱히 필요없는놈 그냥 혹시나해서 둔다)
//--------------------------------
function get_rownum($res){
  // rownum 구하기
  if ($this->inst_mdb2->getOption('result_buffering')){$this->rownum = @$res->numRows();}
else{echo "result_bufferring이 활성화 되어있지 않습니다.";}
}

//--------------------------------
//  필드갯수 세팅  (딱히 필요없는놈 그냥 혹시나해서 둔다)
//--------------------------------
function get_colnum($res){
  // rownum 구하기
  if ($this->inst_mdb2->getOption('result_buffering')){$this->colnum = $res->numCols();}
else{echo "result_bufferring이 활성화 되어있지 않습니다.";}
}

//--------------------------------
//  ASSOC 패치
//--------------------------------
function fetch($query){

  $res = &$this->inst_mdb2->query($query);
  $i=0;
  while ($row = @$res->fetchRow(MDB2_FETCHMODE_ASSOC) ){
    $data[] = $row;
    $i++;
  }


  // rownum 세팅
  $this->rownum = $i;

  return $data;
}

//--------------------------------
//  키값 정렬 패치
//--------------------------------
function fetch_key($query){

  $res = &$this->inst_mdb2->query($query);
  $i=0;
  while ($row = @$res->fetchRow(MDB2_FETCHMODE_ASSOC)){

    foreach ($row as $key => $val){
      $data[$key][$i] = $val;
    // foreach - End
    }

    $i++;
  // while - End
  }

  // rownum 세팅
  $this->rownum = $i;

  return $data;
}


//-----------------------
//  실  행
//-----------------------
function execute($query){
    $affected = @$this->inst_mdb2->exec($query);
    if (PEAR::isError($affected)){die($affected->getMessage());}else{return "ok";}
}

//----------------------
// 트랜젝션
//----------------------
function transaction($action,$savepoint){

  // $savepoint가 있을때
  if($savepoint!=""){

    // 세이브포인트 설정에 문제가 없다면
    if(@$this->inst_mdb2->inTransaction() && $this->inst_mdb2->supports('savepoints')){

      switch($action){

        case "begin" :
          return @$this->inst_mdb2->beginTransaction($savepoint);
        break;

        case "rollback" :
          return @$this->inst_mdb2->rollback($savepoint);
        break;

        case "commit" :
          return @$this->inst_mdb2->commit($savepoint);
        break;

      // switch - End
      }

    }
    // 세이프 포인트 설정에 문제가 있다면
    else{echo "savepoint 설정에 문제가 있습니다.";return false;}
  }
  // $savepoint가 없을때
  else{
    switch($action){

      case "begin" :
        return $this->inst_mdb2->beginTransaction();
      break;

      case "rollback" :
        return $this->inst_mdb2->rollback();
      break;

      case "commit" :
        return $this->inst_mdb2->commit();
      break;

    // switch - End
    }

  // else - End
  }

// function - End
}


//--------------------------------
// rownum 초기화
//--------------------------------
function reset_rownum(){
  unset($this->inst_mdb2->rownum);
}


//--------------------------------
// 종  료
//--------------------------------
function close(){
  $this->inst_mdb2->disconnect();
}

// class - End
}

?>
