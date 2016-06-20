<%@ page contentType="text/html;charset=utf-8" %>
<script type="text/javascript">
$(document).ready(function(){
	   $(window).resize();
});
$(window).resize(function(){
    $('.mainDiv').css({position:'absolute'}).css({
        left: ($('#section').width() - $('.mainDiv').width())/2,
        top: ($('#section').height() - $('.mainDiv').height())/2
    });
  });
</script>
<div class="mainDiv">
<div style="width:810px;height:610px;">
<div style="float:left; width:400px; height:300px; background-color: aqua;">1번</div>
<div style=" float:left; width:400px; height:300px; margin-left:5px; background-color: fuchsia;">2번</div>

<div style="float:left; width:400px; height:300px; margin-top:5px; background-color: maroon;">3번</div>
<div style=" float:left; width:400px; height:300px; margin-top:5px; margin-left:5px; background-color: silver;">4번</div>
</div>
</div>