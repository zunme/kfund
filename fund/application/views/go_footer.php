<div id="rightArea" class="right_aside_area">
    <div class="inner">
        <!-- 우측 공통 영역 -->
        <!--script type="text/javascript" src="/realty/resources/js/realty_right_area.js" charset="utf-8"></script-->
<iframe src="http://realty.chosun.com/realty/dhtm/right_iframe.html" width="320" height="1100" frameborder="0" scrolling="no"></iframe>

    </div>
    <!-- //inner -->
</div>
<!-- //right_aside_area -->
</div>
<!-- //contents -->
</div>
<!-- //container -->
<footer id="footer" class="footer">
<script type="text/javascript" src="http://realty.chosun.com/realty/resources/js/footer_pkg.js" charset="utf-8"></script>
</footer>
<!-- //footer -->

</div>
<!-- //wrapper -->

<script type="text/javascript" src="http://realty.chosun.com/realty/resources/js/realty_ui.js" charset="utf-8"></script>
<!--script type="text/javascript" src="/realty/resources/js/realty_cat_view.js" charset="utf-8"></script-->
<script>
$(document).on('click', 'a.pjax', function(e){ // pjax라는 클래스를 가진 앵커태그가 클릭되면,
    $.pjax({
        url: $(this).attr('href'), // 앵커태그가 이동할 주소 추출
        fragment: '#fund-main', // 위 주소를 받아와서 추출할 DOM
        container: '#fund-main' // 위에서 추출한 DOM 내용을 넣을 대상
    });
    return false;
});
// for google analytics
$(document).on('pjax:end', function() {
    ga('set', 'location', window.location.href); // 현재 바뀐 주소를
    ga('send', 'pageview'); // 보고한다
});
</script>

</body>
</html>
