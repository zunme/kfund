<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class boardapi extends CI_Controller {
  function boardlist() {
    $start = ($this->input->get('per_page')<1)? 0 : $this->input->get('per_page');
    $perpage = ($this->input->get('per')<1)? 5 : $this->input->get('per');
    $target = ($this->input->get('target') !='' ) ?$this->input->get('target') : 'board';

    $sql = "
      from mari_write
      where w_table = '".$this->input->get('table')."' and w_main_exposure ='Y'
    ";
    if( $this->input->get('cate') != '' ){
      $sql .=" and w_catecode ='".$this->input->get('cate')."' ";
    }
    if( $this->input->get('catenot') != '' ){
      $sql .=" and w_catecode !='".$this->input->get('catenot')."' ";
    }
    if( $this->input->get('search') != '' ){
      $sql .=" and w_subject like'%".$this->db->escape_str($this->input->get('search')) ."%' ";
    }
    $count = $this->db->query('select count(1) as cnt '.$sql)->row_array();
    $list =  $this->db->query('select w_id, w_subject,w_hit, date_format( w_datetime,"%Y.%m.%d") as w_datetime,"" as w_notice '.$sql.' order by w_datetime desc limit '.$start .','.$perpage)->result_array();

    if( $this->input->get('noti')=='Y'){
      $sql2 = "select w_id, w_subject,w_hit, date_format( w_datetime,'%Y.%m.%d') as w_datetime,'Y' as w_notice   from mari_write
            where w_table = '".$this->input->get('table')."' and w_main_exposure ='Y' and w_notice='Y' order by w_datetime desc;";
      $list2 = $this->db->query($sql2)->result_array();
      if( count($list2)>0 ){
        if(count($list) >0) $list = array_merge($list2,$list);
        else $list=$list2;
      }
    }

    $this->load->library('pagination');
    $config['base_url'] = '/api/index.php/boardapi/boardlist?table='.$this->input->get('table').'&per='.$perpage.'&cate='.$this->input->get('cate').'&target='.$target.'&search='.$this->input->get('search');
    $config['total_rows'] = isset($count['cnt']) && $count['cnt']>0 ? $count['cnt'] : 0;
    $config['per_page'] = $perpage;
    $config['num_links'] = ($this->input->get('per_page')<1)? 5 : 2;
    $config['page_query_string'] = true;

  $config['first_link'] =false;
  $config['last_link'] =false;
  /*
    $config['first_link'] = '이전';
    $config['first_tag_open'] = '<span class="prev">';
    $config['first_tag_close'] = '</span>';

    $config['last_link'] = '다음';
    $config['last_tag_open'] = '<span class="next">';
    $config['last_tag_close'] = '</span>';

    $config['next_link'] = false;
    $config['prev_link'] = false;
    */
    $config['prev_link'] = '&lt;&lt;';
    $config['prev_tag_open'] = '<span class="prev">';
    $config['prev_tag_close'] = '</span>';
    $config['next_link'] = '&gt;&gt;';
    $config['next_tag_open'] = '<span class="next">';
    $config['next_tag_close'] = '</span>';

    $config['cur_tag_open'] = '<span class="on">';
    $config['cur_tag_close'] = '</span>';

    $config['num_tag_open'] = '<span>';
    $config['num_tag_close'] = '</span>';

    $this->pagination->initialize($config);

    echo json_encode(array('list'=>$list, 'page'=>$this->pagination->create_links2($target)));
  }
}
/*
<span class="prev"><a href="#" target="_self">이전</a></span>
<span class="on">1</span>
<span><a href="#" target="_self">2</a></span>
<span><a href="#" target="_self">3</a></span>
<span><a href="#" target="_self">4</a></span>
<span><a href="#" target="_self">5</a></span>
<span class="next"><a href="#" target="_self">다음</a></span>
*/
