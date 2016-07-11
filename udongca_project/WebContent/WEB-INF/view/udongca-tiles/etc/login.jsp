<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function(){
	$('#find_id').click(function(){
		$('#id_error_span').empty();
		$('#find_id_modal').modal();
	});
	
	$('#find_pwd').click(function(){
		$('#pwd_error_span').empty();
		$('#find_pwd_modal').modal();
	});
	
	
	
	
	$('#find_id_btn').click(function(){
		
		$.ajax({
			'url':'/udongca_project/memberId_find.udc',
			'type':'post',
			'data':{'memberName':$('#memberName_id').val(),'memberEmail':$('#memberEmail_id').val()},
			'dataType':'text',
			'success':function(text){
				message=text;
			},
			'beforeSend':function(){
				$('#loading_modal').modal();
			},
			'complete':function(){
				setTimeout(function(){
					$('#loading_modal').modal('hide');
					if(message != '정보가 일치하는 아이디가 없습니다.'){
						alert(message);
						$('#memberName_id').val("");
						$('#memberEmail_id').val("");
						$('#find_id_modal').modal('hide');
					}
					else{
						$('#id_error_span').empty();
						$('#id_error_span').append('<font style="color:red;">'+message+'</font>');
					}
				},1000)
			}
		});
		
	})
	
	$('#find_pwd_btn').click(function(){
		var message='';
		$.ajax({
			'url':'/udongca_project/memberPassword_find.udc',
			'type':'post',
			'data':{'memberId':$('#memberId').val(),'memberName':$('#memberName_pwd').val(),'memberEmail':$('#memberEmail_pwd').val()},
			'dataType':'text',
			'success':function(text){
				message=text;
			},
			'beforeSend':function(){
				$('#loading_modal').modal();
			},
			'complete':function(){
				setTimeout(function(){
					$('#loading_modal').modal('hide');
					if(message != '정보가 일치하는 회원이 없습니다.'){
						alert(message);
						$('#memberId').val("");
						$('#memberName_pwd').val("");
						$('#memberEmail_pwd').val("");
						$('#find_pwd_modal').modal('hide');
					}
					else{
						$('#pwd_error_span').empty();
						$('#pwd_error_span').append('<font style="color:red;">'+message+'</font>');
					}
				},1000)
			}
		});
		
	})
	
});
</script>
<style type="text/css">
.form-group{
	vertical-align: bottom;
}

        .center
        {
            margin: 300px auto;
            padding: 10px;
            width: 130px;
            background-color: White;
            border-radius: 10px;
            filter: alpha(opacity=100);
            opacity: 1;
            -moz-opacity: 1;
        }
        .center img
        {
            height: 120px;
            width: 120px;
        }
</style>
<div class="nonav_bodyDiv" id="loginPage" style="width: 555px; height: 170px;margin:0 auto;margin-top:150px;">
<div style="min-height: auto; width: 555px;">
	<form action="/udongca_project/member/login.udc" method="post" onsubmit="return loginCheck();">
	<div style="float:left; width:230px;">
		<div style="width:200px; min-height:30px;"><input type="text" class="form-control" style="width:400px; height: 60px; font-size: 20pt" placeholder="아이디" id="id" name="id"></div>
		<div style="width:200px; min-height:30px;"><input type="password" style="width:400px; height: 60px; font-size:20pt;" placeholder="비밀번호" id="password" name="password"></div>
		<c:if test="${not empty requestScope.error }"><div style="width:400px;"><font color="red">${requestScope.error }</font></div></c:if>
	</div>
	<div><button type="submit" style="width:150px; height:120px; float:right;">로그인</button></div>
	</form>
	
	<div style="padding-top:15px;clear: both;">
		<a id="find_id">아이디 찾기</a>
		/
		<a id="find_pwd">비밀번호 찾기</a>
	</div>

</div>
<!-- 아이디 찾기 modal -->
<div class="modal fade" id="find_id_modal" role="dialog" align="center">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content" style="width:400px;">
        <div class="modal-header">
          <h4>아이디 찾기</h4>
        </div>
        <div class="modal-body" style="padding:40px 50px;">
          <form class="form-inline" role="form">
            <div class="form-group">
          		<span id="id_error_span"></span>
          	</div>
            <div class="form-group" >
              <label for="memberName_id" class="col-xs-1" style="width:100px">이름</label>
              <input type="text" class="form-control" id="memberName_id" placeholder="이름을 입력하세요">
            </div><br>
            <div class="form-group">
              <label for="memberEmail_id" class="col-xs-1" style="width:100px">이메일</label>
              <input type="text" class="form-control" id="memberEmail_id" placeholder="이메일을 입력하세요">
            </div><br>
            <div align="right">
              <button id="find_id_btn" type="button" class="btn btn-success btn-block" style="margin-top:15px;">찾기</button>
              <button class="btn btn-default" data-dismiss="modal" style="margin-top:15px;">닫기</button>
            </div>
          </form>
        </div>
      
      </div>
      
    </div>
  </div>
  
  <!-- 비밀번호 찾기 modal -->
  <div class="modal fade" id="find_pwd_modal" role="dialog" align="center">
    <div class="modal-dialog" >
      <!-- Modal content-->
      <div class="modal-content" style="width:400px;">
        <div class="modal-header">
          <h4>비밀번호 찾기</h4>
        </div>
        <div class="modal-body" style="padding:40px 50px;">
            <div class="form-group">
          		<span id="pwd_error_span"></span>
          	</div>
          <form class="form-inline" role="form">
            <div class="form-group" >
              <label for="memberId" class="col-xs-1" style="width:100px">아이디</label>
              <input type="text" class="form-control" id="memberId" placeholder="아이디를 입력하세요">
            </div><br>
            <div class="form-group" >
              <label for="memberName_pwd" class="col-xs-1" style="width:100px">이름</label>
              <input type="text" class="form-control" id="memberName_pwd" placeholder="이름을 입력하세요">
            </div><br>
            <div class="form-group">
              <label for="memberEmail_pwd" class="col-xs-1" style="width:100px">이메일</label>
              <input type="text" class="form-control" id="memberEmail_pwd" placeholder="이메일을 입력하세요">
            </div><br>
            <div align="right">
              <button id="find_pwd_btn" type="button" class="btn btn-success btn-block" style="margin-top:15px;">찾기</button>
              <button class="btn btn-default" data-dismiss="modal" style="margin-top:15px;">닫기</button>
            </div>
          </form>
        </div>
      
      </div>
      
    </div>
  </div>
  
  
  <div class="modal fade" role="dialog" id="loading_modal" style="display: none;">
           	 <div class="center">
           	 <img alt="" src="/udongca_project/images/loader.gif" />
           	 </div>
    </div>
</div>