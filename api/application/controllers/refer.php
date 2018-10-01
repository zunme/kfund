<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
  class Refer extends CI_Controller {
    function _remap($method) {
      date_default_timezone_set('Asia/Seoul');
      $this->db = $this->load->database('real',true);
      $sql = "
      insert z_referer_parse ( logdate, domain, cnt, joincnt)
      select a.logdate, a.domain, cnt, ifnull(joincnt,0)
      from (
      	select logdate, domain , count(1) as cnt
      	   from (
      			select
      			logdate ,
      			case
      				when ( firsttab = 'postview.nhn') then blogid
      				when ( firsttab = 'articleread.nhn') then clubid
      				when ( domaintype = 'cafe') then concat('CAFE:',firsttab)
      			else domain
      			end  as domain
      			from
      			(
      			select
      			SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(REPLACE(LOWER(referer), 'https://', ''), 'http://', ''), '/', 1), '?', 1) AS domain
      			,SUBSTRING_INDEX( SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(REPLACE(LOWER(referer), 'https://', ''), 'http://', ''), '/', 1), '?', 1),'.', 1) as domaintype
      			, SUBSTRING_INDEX( SUBSTRING_INDEX( SUBSTRING_INDEX(REPLACE(REPLACE(LOWER(referer), 'https://', ''), 'http://', ''), '/', 2) , '/', -1), '?', 1)
      				as firsttab
      			, concat( 'CLUB_ID:', SUBSTRING_INDEX( SUBSTRING_INDEX( REPLACE(LOWER(referer), 'clubid=', '@@@@'), '&', 1), '@@@@', -1) ) as clubid
      			, concat( 'BLOG_ID:', SUBSTRING_INDEX( SUBSTRING_INDEX( REPLACE(LOWER(referer), 'blogid=', '@@@@'), '&', 1), '@@@@', -1) ) as blogid
      			, date_format(regdate, '%Y-%m-%d') as logdate
      			,referer
      			from z_referer
            	where regdate < date_format( now() , '%Y-%m-%d 00:00:00' )
            			and regdate >= date_format( date_sub( now() , interval 1 day) , '%Y-%m-%d 00:00:00')
      			) refertmp
      		) grptmp1
      	group by domain	) a
      left join (
      	select logdate, domain , count(1) as joincnt
      	from (
      		select
      			logdate ,
      			case
      				when ( firsttab = 'postview.nhn') then blogid
      				when ( firsttab = 'articleread.nhn') then clubid
      				when ( domain='cafe.naver.com' and domaintype = 'cafe') then concat('CAFE:',firsttab)
      			else domain
      			end  as domain
      		from
      			(
      				select
      				SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(REPLACE(LOWER(referer), 'https://', ''), 'http://', ''), '/', 1), '?', 1) AS domain
      				,SUBSTRING_INDEX( SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(REPLACE(LOWER(referer), 'https://', ''), 'http://', ''), '/', 1), '?', 1),'.', 1) as domaintype
      				, SUBSTRING_INDEX( SUBSTRING_INDEX( SUBSTRING_INDEX(REPLACE(REPLACE(LOWER(referer), 'https://', ''), 'http://', ''), '/', 2) , '/', -1), '?', 1)
      					as firsttab
      				, concat( 'CLUB_ID:', SUBSTRING_INDEX( SUBSTRING_INDEX( REPLACE(LOWER(referer), 'clubid=', '@@@@'), '&', 1), '@@@@', -1) ) as clubid
      				, concat( 'BLOG_ID:', SUBSTRING_INDEX( SUBSTRING_INDEX( REPLACE(LOWER(referer), 'blogid=', '@@@@'), '&', 1), '@@@@', -1) ) as blogid
      				, date_format(regdate, '%Y-%m-%d') as logdate
      				,referer
      				from z_referer_join
         			where regdate < date_format( now() , '%Y-%m-%d 00:00:00' )
      	   			and regdate >= date_format( date_sub( now() , interval 1 day) , '%Y-%m-%d 00:00:00')
      			) refertmp1
      )refgrp1 group by logdate, domain
      ) b on a.logdate = b.logdate and a.domain = b.domain
      ";
      $this->db->query($sql);
      $sql = "
      insert z_referer_log
       select * from z_referer where regdate < date_format( now() , '%Y-%m-%d 00:00:00' );
      ";
      $this->db->query($sql);
      $sql = "
      delete from z_referer where regdate < date_format( now() , '%Y-%m-%d 00:00:00' );
      ";
      $this->db->query($sql);
      $this->{$method}();
    }
      function index() {
        $this->load->view('refer');
      }
      function getlog(){
        $start = $this->input->get('startd');
        $end = $this->input->get('endd');

        $sql = "
        select domain, sum(cnt) cnt, sum(joincnt) joincnt
        from z_referer_parse
        where logdate >= ? and logdate <= ?
        group by domain
        ";
        $sql ="
          select domain, sum(cnt) cnt, ifnull(sum(joincnt),0) joincnt
            from
          (
          	(
          	   select  logdate, domain,  cnt,  joincnt
      	        from z_referer_parse
                where logdate >= '".$start."' and logdate <= '".$end."'
          	)
          	union all
          	(
              select a.logdate, a.domain, cnt, ifnull(joincnt,0)
              from (
              	select logdate, domain , count(1) as cnt
              	   from (
              			select
              			logdate ,
              			case
              				when ( firsttab = 'postview.nhn') then blogid
              				when ( firsttab = 'articleread.nhn') then clubid
              				when ( domaintype = 'cafe') then concat('CAFE:',firsttab)
              			else domain
              			end  as domain
              			from
              			(
              			select
              			SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(REPLACE(LOWER(referer), 'https://', ''), 'http://', ''), '/', 1), '?', 1) AS domain
              			,SUBSTRING_INDEX( SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(REPLACE(LOWER(referer), 'https://', ''), 'http://', ''), '/', 1), '?', 1),'.', 1) as domaintype
              			, SUBSTRING_INDEX( SUBSTRING_INDEX( SUBSTRING_INDEX(REPLACE(REPLACE(LOWER(referer), 'https://', ''), 'http://', ''), '/', 2) , '/', -1), '?', 1)
              				as firsttab
              			, concat( 'CLUB_ID:', SUBSTRING_INDEX( SUBSTRING_INDEX( REPLACE(LOWER(referer), 'clubid=', '@@@@'), '&', 1), '@@@@', -1) ) as clubid
              			, concat( 'BLOG_ID:', SUBSTRING_INDEX( SUBSTRING_INDEX( REPLACE(LOWER(referer), 'blogid=', '@@@@'), '&', 1), '@@@@', -1) ) as blogid
              			, date_format(regdate, '%Y-%m-%d') as logdate
              			,referer
              			from z_referer
                    	where regdate >= date_format( now() , '%Y-%m-%d 00:00:00' )
              			) refertmp
              		) grptmp1
              	group by domain	) a
              left join (
              	select logdate, domain , count(1) as joincnt
              	from (
              		select
              			logdate ,
              			case
              				when ( firsttab = 'postview.nhn') then blogid
              				when ( firsttab = 'articleread.nhn') then clubid
              				when ( domain='cafe.naver.com' and domaintype = 'cafe') then concat('CAFE:',firsttab)
              			else domain
              			end  as domain
              		from
              			(
              				select
              				SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(REPLACE(LOWER(referer), 'https://', ''), 'http://', ''), '/', 1), '?', 1) AS domain
              				,SUBSTRING_INDEX( SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(REPLACE(LOWER(referer), 'https://', ''), 'http://', ''), '/', 1), '?', 1),'.', 1) as domaintype
              				, SUBSTRING_INDEX( SUBSTRING_INDEX( SUBSTRING_INDEX(REPLACE(REPLACE(LOWER(referer), 'https://', ''), 'http://', ''), '/', 2) , '/', -1), '?', 1)
              					as firsttab
              				, concat( 'CLUB_ID:', SUBSTRING_INDEX( SUBSTRING_INDEX( REPLACE(LOWER(referer), 'clubid=', '@@@@'), '&', 1), '@@@@', -1) ) as clubid
              				, concat( 'BLOG_ID:', SUBSTRING_INDEX( SUBSTRING_INDEX( REPLACE(LOWER(referer), 'blogid=', '@@@@'), '&', 1), '@@@@', -1) ) as blogid
              				, date_format(regdate, '%Y-%m-%d') as logdate
              				,referer
              				from z_referer_join
                 			where regdate >= date_format( now() , '%Y-%m-%d 00:00:00' )
              			) refertmp1
              )refgrp1 group by logdate, domain
              ) b on a.logdate = b.logdate and a.domain = b.domain
          	)
          ) tmp1 where logdate >= '".$start."' and logdate <= '".$end."'
                  group by domain
        ";
        $data = $this->db->query($sql)->result_array();

        $label = $in = $join = array();
        foreach ( $data as $idx=>$row) {
          $label[] = $row['domain'];
          $in[] = $row['cnt'];
          $join[] = $row['joincnt'];
        }
        $sql = "
        select
           idx, ip, mid, referer, regdate,
           case
             when ( firsttab = 'postview.nhn') then blogid
             when ( firsttab = 'articleread.nhn') then clubid
             when ( domain='cafe.naver.com' and domaintype = 'cafe') then concat('CAFE:',firsttab)
           else domain
           end  as domain
           , ifnull(group_concat('<p>',inv.i_subject,' [',FORMAT(inv.i_pay,0),'원]</p>' SEPARATOR '' ),'') as subjs
         from
           (
             select
             SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(REPLACE(LOWER(referer), 'https://', ''), 'http://', ''), '/', 1), '?', 1) AS domain
             ,SUBSTRING_INDEX( SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(REPLACE(LOWER(referer), 'https://', ''), 'http://', ''), '/', 1), '?', 1),'.', 1) as domaintype
             , SUBSTRING_INDEX( SUBSTRING_INDEX( SUBSTRING_INDEX(REPLACE(REPLACE(LOWER(referer), 'https://', ''), 'http://', ''), '/', 2) , '/', -1), '?', 1)
               as firsttab
             , concat( 'CLUB_ID:', SUBSTRING_INDEX( SUBSTRING_INDEX( REPLACE(LOWER(referer), 'clubid=', '@@@@'), '&', 1), '@@@@', -1) ) as clubid
             , concat( 'BLOG_ID:', SUBSTRING_INDEX( SUBSTRING_INDEX( REPLACE(LOWER(referer), 'blogid=', '@@@@'), '&', 1), '@@@@', -1) ) as blogid
             , a.*
             from z_referer_join a
             where a.mid != '' and regdate >='".$start." 00:00:00' and regdate <='".$end." 23:59:59'
           ) refertmp1
           left join mari_invest inv on refertmp1.mid = inv.m_id
           group by refertmp1.idx
        ";
        $list = $this->db->query($sql)->result_array();

        $sql = "select ifnull( count(1), 0) total from mari_member where m_datetime >= ? and m_datetime <= ?";
        $data = $this->db->query($sql, array($start." 00:00:00", $end." 23:59:59"))->row_array();
        echo json_encode( array('label'=>$label,'in'=>$in,'join'=>$join,'list'=>$list, 'total'=>$data['total']) );
      }
  }
