<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Csvup extends CI_Controller {
	function __construct()
	{
		parent::__construct();
		$this->load->helper(array('form', 'url'));
	}
	
	function index()
	{	
		?>
<html>
<head>
<title>Upload Form</title>
</head>
<body>

<form action="/api/index.php/csvup/do_upload" method="post" accept-charset="utf-8" enctype="multipart/form-data">
<input type="file" name="userfile" size="20" />

<br /><br />

<input type="submit" value="upload" />

</form>

</body>
</html>		
		<?php
	}

	function do_upload()
	{
		$config['upload_path'] = '/tmp/';
		$config['allowed_types'] = '*';
		$config['max_size']	= '10000';
		
		$this->load->library('upload', $config);
	
		if ( ! $this->upload->do_upload())
		{
			var_dump($this->upload->display_errors());
			//$error = array('error' => $this->upload->display_errors());
			
			//$this->load->view('upload_form', $error);
		}	
		else
		{
			$data = array('upload_data' => $this->upload->data());
			$file = $data['upload_data']['full_path']; 

			$csvreader = new csvreader();
			$result =   $csvreader->parse_file($file);//path to csv file
	
			$data['csvData'] =  $result;
			$this->db->query('truncate table tmp_membercheck');
			foreach ($data['csvData'] as $row){
				$this->db->insert('tmp_membercheck', array('m_id'=>$row['id']));
			}
			$sql = "
			select a.m_id, if( b.m_id is null , '비회원', '회원') as ismem, replace(replace(b.m_hp,'-', ''),' ', '') as m_hp, m_name
			from tmp_membercheck a
			left join mari_member b on a.m_id = b.m_id			
			";
			$ret = $this->db->query($sql)->result_array();
			$i=0;
			?>
<html>
<head>
<title>Upload Form</title>
</head>
<body>

<form action="/api/index.php/csvup/do_upload" method="post" accept-charset="utf-8" enctype="multipart/form-data">
<input type="file" name="userfile" size="20" /><input type="submit" value="upload" /></form>
</body>			
			<table width=100%>
				<?php foreach ($ret as $row) {?>
				<tr><td><?php echo ++$i ?></td><td><?php echo $row['m_id']?></td><td><?php echo $row['ismem']?><td><?php echo $row['m_hp']?></td><td><?php echo $row['m_name']?></td>
				<?php } ?>
			</table>
			<?
		}
	}	
}

class CSVReader {

    var $fields;            /** columns names retrieved after parsing */ 
    var $separator  =   ';';    /** separator used to explode each line */
    var $enclosure  =   '"';    /** enclosure used to decorate each field */

    var $max_row_size   =   4096;    /** maximum row size to be used for decoding */

    function parse_file($p_Filepath) 
    {
        $file           =   fopen($p_Filepath, 'r');
        $this->fields   =   fgetcsv($file, $this->max_row_size, $this->separator, $this->enclosure);
        $keys_values        =   explode(',',$this->fields[0]);

        $content            =   array();
        $keys           =   $this->escape_string($keys_values);

        $i  =   1;
        while(($row = fgetcsv($file, $this->max_row_size, $this->separator, $this->enclosure)) != false ) 
        {
            if( $row != null ) { // skip empty lines
                $values         =   explode(',',$row[0]);
                if(count($keys) == count($values)){
                    $arr            =   array();
                    $new_values =   array();
                    $new_values =   $this->escape_string($values);
                    for($j=0;$j<count($keys);$j++){
                        if($keys[$j]    !=  ""){
                            $arr[$keys[$j]] =   $new_values[$j];
                        }
                    }
                    $content[$i]    =   $arr;
                    $i++;
                }
            }
        }
        fclose($file);
        return $content;
    }

    function escape_string($data)
    {
        $result =   array();
        foreach($data as $row){
            $result[]   =   str_replace('"', '',$row);
        }
        return $result;
    }   
}