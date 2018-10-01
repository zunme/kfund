<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Cast extends CI_Controller {
  var $cate;
  function _remap($method) {
    if ( ! session_id() ) @ session_start();
    $this->session = $_SESSION;
    $this->member_ck = ( isset($this->session['ss_m_id']) &&  $this->session['ss_m_id'] !='' ) ? true: false;
    session_write_close();

    $this->cate = !$this->uri->segment(2) ? 'All': $this->uri->segment(2);
    if($method =='view') {
      $this->view();
    }else $this->index();
  }
  function view() {
    $row = $this->db->get_where('z_cast', array('isview'=>'Y','cast_idx'=>(int)$this->input->get('idx') ))->row_array();
    if( !isset($row['cast_idx'])) {
      $this->load->view('cast_view', array('data'=>array('cast_title'=>"없는 페이지 입니다." , 'cast_body'=>'') ));
    }else {
      $this->load->view('cast_view', array('data'=>$row));
    }
  }
  function index() {
    if( $this->input->get('search') !='' ){
      $config['base_url'] = '/api/cast/'.$this->cate.'/search/'.urlencode($this->input->get('search')).'/'.$this->cate.'/page/';
      $config['uri_segment'] = 6;
      $search = $this->input->get('search');
    }
    else if( $this->uri->segment(3)=="search" ){
      $config['base_url'] = '/api/cast/'.$this->cate.'/search/'.$this->uri->segment(4).'/'.$this->cate.'/page/';
      $config['uri_segment'] = 7;
      $search = urldecode($this->uri->segment(4));
    }else {
      $config['base_url'] = '/api/cast/'.$this->cate.'/page/';
      $config['uri_segment'] = 4;
      $search = false;
    }

    $config['num_links'] = 2;
    $config['per_page'] = 3;
    $config['use_page_numbers'] = TRUE;

    $page = !$this->uri->segment($config['uri_segment']) ? 0 : $this->uri->segment($config['uri_segment']);

    $top = $this->db->query("select * from z_cast where isview='Y' and notice='Y' limit 1")->row_array();
    if(!isset($top['cast_idx'] )){
      $top = $this->db->query("select * from z_cast where isview='Y' order by cast_idx desc limit 1")->row_array();
    }

    $where['isview'] ='Y';$where['notice'] ='N';
    switch ($this->cate){
      case ('Prd'):
       $where['loan_id >'] ='0';
        break;
      case ('Info'):
      $where['loan_id'] ='0';
        break;
    }

    $this->db->where($where);
    if( $search != false ){
      $this->db->like ('cast_title' , $search );
    }
    $config['total_rows'] =  $this->db->count_all_results('z_cast') ;

    $this->db->where($where);
    if( $search != false ){
      $this->db->like ('cast_title' , $search );
    }
    $list = $this->db->order_by('cast_idx desc')->limit($config['per_page'],$page)->get('z_cast')->result_array();

    $this->load->library('pagination');


    $config['full_tag_open'] = '';
    $config['full_tag_close'] = '';

    $config['first_link'] = FALSE;
    $config['last_link'] = FALSE;
    $config['next_link'] = '&gt;';
    $config['prev_link'] = '&lt;';

    $config['cur_tag_open'] = '<li class="active"><a href="javascript">';
    $config['cur_tag_close'] = '</a></li>';

    $config['first_tag_open'] =$config['last_tag_open'] =$config['next_tag_open'] = $config['prev_tag_open'] = $config['num_tag_open'] = '<li>';
    $config['first_tag_close'] =$config['last_tag_close'] =$config['next_tag_close'] = $config['prev_tag_close'] =$config['num_tag_close'] = '</li>';
    $this->pagination->initialize($config);
    $pages =$this->pagination->create_links();


    $this->load->view('cast', array("top"=>$top, "list"=>$list, "pages"=>$pages));
  }
}
