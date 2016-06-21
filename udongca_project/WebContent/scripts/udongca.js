$(document).ready(function(){
/*	$("#idVerification").on("click",function(){
		$.ajax({
				"url":"member/findById.udc",
				"type":"POST",
				"data":"id="+$("#id").val(),
				"dataType":"text",
				"success" : function(id){
					if(id){
						alert("이미 사용중인 아이디입니다. 다른 아이디를 입력해주세요.");
						$("#id").focus();
					}else{
						confirm("사용 가능한 아이디입니다. 사용하시겠습니까?");
						$("#password").focus();
					}
				},
				"beforeSend" : function(){
					if(!$("#id").val()){
						alert("아이디를 입력하세요.");
						$("#id").focus();
						return false;
					}
				}
		})
	});*/
	
	$('#member_modify').on('click',function(){
		location.replace('/udongca_project/member/member_modify_form.udc');
	});

	$('#verify').on('click',function(){
		$.ajax({
			'url':'/udongca_project/member/verify.udc',
			'type':'post',
			'data':{'id':$('#id').val(),'password':$('#password').val()},
			'success':function(txt){
				if(txt == 'true')
					location.replace('/udongca_project/member/modify_form.udc');
				else
					alert(txt);
			}
		});
	});
	
	$('#memberModifyBtn').on('click',function(){
		$.ajax({
			'url':'/udongca_project/member/member_modify.udc',
			'type':'post',
			'data':{'name':$('#name').val(),'password':$('#password').val()},
			'success':function(txt){
				if(txt == 'success'){
					alert("수정 성공. 메인페이지로.");
					location.replace('/udongca_project/main.udc');
				}
				else
					alert(txt);
			}
		});
	});
	if('http://127.0.0.1:4322/udongca_project/member/member_preferLocation_form.udc'==document.URL){
		$.ajax({
			'url':'/udongca_project/member/majorCategory.udc',
			'type':'post',
			'dataType':'json',
			'success':function(list){
				var options = "<option>시/도 선택</option>";
				for(var index = 0 ; index < list.length; index++){
					options = options + "<option value="+list[index].majorCategoryNo+">"+list[index].address1+"</option>";
				}
				$("#first_major").html(options);
			}
		});
	}
	
	
	$(window).resize();
	
});


$(window).resize(function(){
    $('.nonav_bodyDiv').css({position:'absloute'}).css({
        left: ($('.nonav_section').width() - $('.nonav_bodyDiv').width())/2,
        top: ($('.nonav_section').height() - $('.nonav_bodyDiv').height())/2
    });
    
    $('.nav_bodyDiv').css({position:'absolute'}).css({
    	left: $('.nav').width()+($('.nav_section').width() - $('.nav_bodyDiv').width())/2,
        top:($('.nav_section').height() - $('.nav_bodyDiv').height())/2
    });
  });