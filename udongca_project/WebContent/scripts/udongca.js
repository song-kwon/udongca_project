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
	
	
	/*정보수정 클릭시 비밀번호 확인 페이지에서 버튼 클릭 이벤트*/
	$('#verify').on('click',function(){
		$.ajax({
			'url':'/udongca_project/member/verify.udc',
			'type':'post',
			'data':{'id':$('#id').val(),'password':$('#password').val()},
			'success':function(txt){
				if(txt == 'true')
					location.replace('/udongca_project/member/member_modify_form.udc');
				else
					alert(txt);
			}
		});
	});
	
	
	/*수정폼에서 수정 버튼 클릭*/
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
	
	$("#memberInquiryList").on("click", "tr", function(){//tr에 event 처리
			location.replace('/udongca_project/oneToOneInquiry/oneToOneInquiry.udc?inquiryNo='+$(this).find(':first').text());
		});
		
	
		$('.major_category').bind('change',getMiddleCategory);
				
		/*수정 버튼 클릭*/
		$('#preferLocation_modiftBtn').on('click',function(){
			var major_category = [$('#first_category').val(),
					$('#second_category').val(),
					$('#third_category').val()];
			
			var middle_category= [$('select[name=first_category]').val(),
					$('select[name=second_category]').val(),
					$('select[name=third_category]').val()];

			alert($("select[name='first_category']").val());
			$.ajax({
				'url':'/udongca_project/member/modify_preferLocation.udc',
				'type':'post',
				'data':'location='+middle_category,
				'dataType':'text',
				'success':function(txt){
					location.reload();
				}
			});
			
		});
	
	
	/*$(window).resize();*/
	
});


/*$(window).resize(function(){
    $('.nonav_bodyDiv').css({position:'absloute'}).css({
        left: ($('.nonav_section').width() - $('.nonav_bodyDiv').width())/2,
        top: ($('.nonav_section').height() - $('.nonav_bodyDiv').height())/2
    });
    
    $('.nav_bodyDiv').css({position:'absolute'}).css({
    	left: $('.nav').width()+($('.nav_section').width() - $('.nav_bodyDiv').width())/2,
        top:($('.nav_section').height() - $('.nav_bodyDiv').height())/2
    });
  });*/

function getMiddleCategory(){
	var category = this;
	var categoryValue=this.value;
	$.ajax({
		'url':'/udongca_project/member/middleCategory.udc',
		'type':'post',
		'data':'majorNo='+categoryValue,
		'dataType':'json',
		'success':function(list){
			var options = "<option value='0'>군/구 선택</option>";
			for(var index = 0 ; index < list.length; index++){
				options = options + "<option value='"+list[index].middleCategoryNo+"'>"+list[index].addressName+"</option>";
			}
			
			var id=$(category).prop('id');
			$('select[name='+id+']').html(options);
		},
		'beforeSend':function(){
			if(categoryValue == 0){
				var id=$(category).prop('id');
				$('select[name='+id+']').html("<option value='0'>시/도 먼저 선택</option>");
				return false;
			}
		}
		
	});
}

function loginCheck(){
	var loginId = $('#id').val();
	var loginPassword = $('#password').val();
	
	if(loginId.length == 0){
		alert('id를 입력하세요');
		return false;
	}
	
	if(loginPassword.length == 0){
		alert('비밀번호를 입력하세요');
		return false;
	}
	
}

function error(){
	if($('#error').val().length!=0){
		alert($('#error').val());
	}
}

//1:1 문의 ajax
function inquiryAjax(pageNum){
	$.ajax({
		type:"POST", 
		url:"/udongca_project/member/memberInquiryListPaging.udc",
		data:'pnum='+pageNum,
		dataType:"JSON",
		success:function(jsonData){
			$("#tbody").empty();
		
			$.each(jsonData['list'], function(){
				$("#tbody").append(
						$("<tr>").append($("<td>").text(this.inquiryNo))
									  .append($("<td>").text('['+this.inquiryType+']'+this.inquiryTitle))
								  	  .append($("<td>").text(this.inquiryReply == '' ? '처리중':'처리완료'))
				);
			});
			
			var pageBean = jsonData['pageBean'];
			if(pageBean.previousPageGroup){
				$('#previousBtn').attr('href','/udongca_project/member/memberInquiryListPaging.udc?pnum='+pageBean.beginPage-1);
			}
			var num="";
			
			for (var idx = pageBean.beginPage; idx <= pageBean.endPage; idx++) {
			
				if(idx!=pageBean.page){
					num = num + '<a class="pageNum">'+idx+'</a>';
				}else{
					num = num + '['+idx+']'
				}
			}
			
			$('#pageBtn').empty().html(num);
			
			if(pageBean.nextPageGroup){
				$('#endBtn').attr('href','/udongca_project/member/memberInquiryListPaging.udc?pnum='+pageBean.endPage+1);
			}
			
		}
	});
}

