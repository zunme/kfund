<!-- table -->
<link href="/pnpinvest/layouts/home/pnpinvest/gentelella/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
<style>
.memlogin i ,.details-inv, .viewinterest, .linked_class,.seyfertemoneyrefresh { color: #008EFC; cursor:pointer;}
td span { line-height: 0;}
span.seyfertemoney {min-height: 20px; border: 1px solid #175ED2;}
table.innertable td {padding :5px; border-bottom :1px solid #888;border-bottom-width: 1px;}
table.innertable td:nth-child(2) {text-align:right;}
i.fa-comment , i.fa-info-circle{padding-left: 10px;}
span.pendingsf_use{text-align: center;color:#337ab7;cursor:pointer;}
</style>
            <div class="row">

              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Userlist <small>회원목록</small>
                      <div style="display:inline">
                      <a href="/api/index.php/adm/mreferer" class="btn btn-xs btn-success" style="margin-left:100px;">추천인명단 다운<span class="fa fa-download pull-right" style="margin-top: 2px;padding-left: 4px;"></span></a>
                      </div>
                      <!--form action="/api/index.php/adm/withholdinglist" style="display:inline">
                        <button class="btn btn-xs btn-success" style="margin-left:20px;">원천징수리스트 다운<span class="fa fa-download pull-right" style="margin-top: 2px;padding-left: 4px;"></span></button>
                        <input type="text" style="width: 120px;display:inline" name="yearmonth" class="form-control singlepicker" value="" />
                        <!--~<input type="text" style="width: 120px;display:inline" name="enddate" class="form-control singlepicker" value="" />-->
                      </form-->



                    </h2>

                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class="row">
                      <div style="float:left;margin-left:2em;margin-bottom:5px;">
                        <input id="emoneycheck" type="checkbox" name="emoneycheck" value="Y" >emoney자동확인
                      </div>
                      <div style="float:right;margin-right:2em;margin-bottom:5px;">
                        <input id="isnotauthed" type="checkbox" name="isnotauthed" value="Y" onClick="fnchanged()">확인안된유저
                        <select id="searchlevel" name="level" class="input-sm" style="margin-left: 20px;" onChange="fnchanged()">
                          <option value="" >선택</option>
                        <?php
                          foreach ($levellist as $idx=>$val){
                            ?>
                            <option value="<?php echo $idx?>" ><?php echo $val?></option>
                            <?php
                          }
                        ?>
                        </select>
                      </div>
                    </div>
                    <script>
                      function fnchanged(){
                         $('#datatable2').dataTable().fnFilter();
                      }
                    </script>
                    <table id="datatable2" class="table table-striped table-bordered"  class="display nowrap" cellspacing="0" width="100%">
                      <thead>
                        <tr>
                          <th>no</th>
                          <th>아이디</th>
                          <th>이름</th>
                          <th>HP</th>
                          <th>가상</th>
                          <th>계좌</th>
                          <th>emoney</th>
                          <th>남은한도</th>
                          <th>등급</th>
                          <th>추천인/투자호수</th>
                          <th>SMS</th>
                          <th>확인</th>
                        </tr>
                      </thead>
                      <tbody>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
              <!--  / -->
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>LonList <small>대출목록</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li><a href="javascript:;" onClick="analfirst( 'limit5' )"><i class="fa fa-bar-chart"></i></a>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class="row">
                      <div class="col-md-6 col-sm-6 col-xs-12">
                                            <div id="bar-example"></div>
                      </div>
                      <div class="col-md-6 col-sm-6 col-xs-12">
                                            <div id="bar-example2"></div>
                      </div>
                    </div>

                    <table id="datatable1" class="table table-striped table-bordered"  class="display nowrap" cellspacing="0" width="100%">
                      <thead>
                        <tr>
                          <th>id</th>
                          <th>title</th>
                          <th>상환방식</th>
                          <th>상태(투자자목록)</th>
                          <th>대출실행일</th>
                          <th>대출만기일</th>
                          <th>지급여부</th>
                        </tr>
                      </thead>
                      <tbody>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
              <!--    /   -->

            </div>


<!-- table -->
          <br />
          <div class="row">
            <div id="leftsPan" class="col-md-6 col-sm-6 col-xs-6">

            </div>
            <div id="rightsPan" class="col-md-6 col-sm-6 col-xs-6">

            </div>
          </div> <!--row-->
