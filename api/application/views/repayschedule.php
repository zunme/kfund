<!DOCTYPE html>
<html>
<head>
    <title>정산스케쥴</title>
    <meta name="robots" content="noindex, nofollow">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <!-- jQuery CDN -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>

    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap.min.css">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.2/js/bootstrap.min.js"></script>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="//oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="//oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

    <!-- Example style -->
    <link rel="stylesheet" type="text/css" href="//zabuto.com/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="style.css">

    <!-- Zabuto Calendar -->
    <script src="/pnpinvest/js/zabuto_calendar.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/pnpinvest/css/zabuto_calendar.min.css">
    <style>
     p.repayed{color:#CCC;}
     p.repay_ready{color:blue;}
    </style>
</head>
<body>

<!-- container -->
<div class="container example">

    <h1>
        정산<span>스케쥴</span>
    </h1>

    <hr>
    <div class="row">
        <div class="col-xs-5">
          <div id="date-popover" class="popover top"
               style="cursor: pointer; display: block; margin-left: 33%; margin-top: -50px; width: 175px;">
              <div class="arrow"></div>
              <h3 class="popover-title" style="display: none;"></h3>

              <div id="date-popover-content" class="popover-content"></div>
          </div>
            <div id="my-calendar"></div>

            <script type="application/javascript">
                $(document).ready(function () {
                    $("#date-popover").popover({html: true, trigger: "manual"});
                    $("#date-popover").hide();
                    $("#date-popover").click(function (e) {
                        $(this).hide();
                    });
                    $("#my-calendar").zabuto_calendar({
                      today: true,
                      language: "kr",
                      weekstartson: 0,
                      //data:repaydata,
                      //modal:true,
                      ajax: {
                          url: "/api/index.php/repayschedule/getlist",
                          modal: true
                      },
                      action: function () {
                          return myDateFunction(this.id, false);
                      },
                    });
                });
                function myDateFunction(id, fromModal) {
                  console.log("call");
                    $("#date-popover").hide();
                    if (fromModal) {
                        $("#" + id + "_modal").modal("hide");
                    }
                    console.log( $("#" + id).data())
                    var date = $("#" + id).data("date");
                    var hasEvent = $("#" + id).data("hasEvent");
                    console.log(hasEvent)
                    if (hasEvent && !fromModal) {
                        return false;
                    }
                    $("#date-popover-content").html('You clicked on date ' + date);
                    $("#date-popover").show();
                    return true;
                }

                function myNavFunction(id) {
                    $("#date-popover").hide();
                    var nav = $("#" + id).data("navigation");
                    var to = $("#" + id).data("to");
                  }
            </script>

        </div>
        <div class="col-xs-6 col-xs-offset-1" id="desc">


        </div>
    </div>

</div>
<!-- /container -->

</body>
</html>
