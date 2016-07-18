$(document).ready(function(){
	
	$("#address1").on("change", function(){
		var es = this;
		$("#address2").empty().append("<option value='0'>전체</option>");
		if ($(this).val() == "시/도"){
			alert("올바른 시/도를 선택하세요");
			$("#address1").focus();
			return false;
		}
		else{
			$.ajax({
				"url":"/udongca_project/search/selectMiddleAddressByMajorCategoryNo.udc",
				"type":"post",
				"data":"majorCategoryNo=" + $(es).val(),
				"dataType":"json",
				"success":function(json){
					for(var i = 0; i < json.length; i++){
						$("#address2").append("<option value=" + json[i].middleCategoryNo + ">" + json[i].addressName + "</option>");
					}
				}
			});
		}
	});

	$("#searchAddress").on("click", function(){
		$("#theme").val(0);
		
		if ($("#address1").val() == 0){
			alert("시/도를 선택하세요");
			return false;
		}

		if($("#address2").val()==0){
			var submitString = $("#address1 option:selected").text();
		}else{
			var submitString = $("#address1 option:selected").text() + " " + $("#address2 option:selected").text();
			if (submitString == "세종특별자치시 세종시"){
				submitString = "세종특별자치시";
			}
		}
		alert(submitString);
		
		$.ajax({
			"url":"/udongca_project/search/locationSearchResult.udc",
			"type":"POST",
			"data":"cafeAddress=" + submitString + "&page=" + 1,
			"dataType":"json",
			"success":function(json){
				submitString = "'"+submitString+"'";
				$("#searchResult").empty();
				$("#pageNum").empty();
				if (json == null || json.list.length == 0){
					$("#searchResult").append('<td colspan="3" align="center"><h3 style="color:red;">검색 결과가 없습니다.</h3></td>');
					return false;
				}
				else{
					for(var i = 0; i < json.list.length; i++){
						$("#searchResult").append("<div style='margin-left:10px;margin-top:20px;padding-right: 10px;padding-top: 10px;width:200px;height:220px;float:left; text-align: center;'><a href='/udongca_project/prBoard/prView.udc?cafeNo="+json.list[i].cafeNo+"'><img style='width:200px;height:200px;' src='../images/" + json.list[i].cafeFakeImage + "'>"+ json.list[i].cafeName + "</a></div>");
						//$("#searchResult").append(" " + json[i].cafeNo + " " + json[i].cafeName + "<br>");
					}
					
					$("#pageNum").append('<ul class="pagination"></ul>');
					if(json.pageBean.previousPageGroup){
						$(".pagination").append('<li><a href="#" onclick="addressPage('+submitString+','+(json.pageBean.beginPage-1)+')">◀</a></li>');
					}else{
						$(".pagination").append('<li><a href="#">◀</a></li>');
					}
					
					for(var idx = json.pageBean.beginPage ; idx <= json.pageBean.endPage ; idx++){
						if(idx == json.pageBean.page)
							$(".pagination").append('<li class="active"><a>'+idx+'</a></li>');
						else
							$(".pagination").append('<li><a href="#" onclick="addressPage('+submitString+','+idx+')"> '+idx+' </a></li>');
					}
					
					if(json.pageBean.nextPageGroup){
						$(".pagination").append('<li><a href="#" onclick="addressPage('+ submitString+','+ ++json.pageBean.endPage +')">▶</a></li>');
					}else{
						$(".pagination").append('<li><a href="#">▶</a></li>');
					}
				}
			}
		});
	});
	
	
	$("#searchTheme").on("click", function(){
		$("#address1").val(0)
		$("#address2").empty().append('<option value=0>시/도 먼저 선택</option>');
		$("#searchResult").empty();
		
		$.ajax({
			"url":"/udongca_project/search/themeSearchResult.udc",
			"type":"POST",
			"data":"cafeFeature=" + $("#theme").val() + "&page="+1,
			"dataType":"json",
			"success":function(json){
				$("#searchResult").empty();
				$("#pageNum").empty();
				if (json == null || json.list.length == 0){
					$("#searchResult").append('<td colspan="3" align="center"><h3 style="color:red;">검색 결과가 없습니다.</h3></td>');
					return false;
				}
				else{
					for(var i = 0; i < json.list.length; i++){
						$("#searchResult").append("<div style='margin-left:10px;margin-top:20px;padding-right: 10px;padding-top: 10px;width:200px;height:220px;float:left; text-align: center;'><a href='/udongca_project/prBoard/prView.udc?cafeNo="+json.list[i].cafeNo+"'><img style='width:200px;height:200px;' src='../images/" + json.list[i].cafeFakeImage + "'>"+ json.list[i].cafeName + "</a></div>");
						//$("#searchResult").append(" " + json[i].cafeNo + " " + json[i].cafeName + "<br>");
					}
					
					
					$("#pageNum").append('<ul class="pagination"></ul>');
					if(json.pageBean.previousPageGroup){
						$(".pagination").append('<li><a href="#" onclick="themePage('+(json.pageBean.beginPage-1)+')">◀</a><li>');
					}else{
						$(".pagination").append('<li><a href="#">◀</a></li>');
					}
					
					for(var idx = json.pageBean.beginPage ; idx <= json.pageBean.endPage ; idx++){
						if(idx == json.pageBean.page)
							$(".pagination").append('<li class="active"><a>'+idx+'</a></li>');
						else
							$(".pagination").append('<li><a href="#" onclick="themePage('+idx+')"> '+idx+' </a></li>');
					}

					if(json.pageBean.nextPageGroup){
						$(".pagination").append('<li><a href="#" onclick="themePage('+ ++json.pageBean.endPage +')">▶</a></li>');
					}else{
						$(".pagination").append('<li><a href="#">▶</a></li>');
					}
				}
				
 			}
		
		});
	});
	
 	 //var isID = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
	 //alert(isID.test(/*비교할 대상*/)); 




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
					location.href='/udongca_project/member/member_modify_form.udc?flag='+txt;
				else
					alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
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
					alert("수정되었습니다. 메인페이지로 이동합니다.");
					location.href='/udongca_project/main.udc';
				}
				else
					alert(txt);
			},
			'beforeSend':function(){
				var result = confirm("수정하시겠습니까?");
				if(result==true)
					return true;
				else
					return false;
			}
		});
	});
	
	$("#memberInquiryList").on("click", ".tr", function(){//tr에 event 처리
			location.href='/udongca_project/oneToOneInquiry/oneToOneInquiry.udc?inquiryNo='+$(this).find(':first').prop('id');
		});
		
	
		//선호지역 - select
		$('.major_category').bind('click',getMiddleCategory);
				
		/*수정 버튼 클릭*/
		$('#preferLocation_modiftBtn').on('click',function(){
			var major_category = [$('#first_category').val(),
					$('#second_category').val(),
					$('#third_category').val()];
			
			var middle_category= [$('select[name=first_category]').val(),
					$('select[name=second_category]').val(),
					$('select[name=third_category]').val()];

			$.ajax({
				'url':'/udongca_project/member/modify_preferLocation.udc',
				'type':'post',
				'data':'location='+middle_category,
				'dataType':'text',
				'success':function(txt){
					alert('선호지역이 수정되었습니다.');
					location.reload();
				}
			});
			
		});
	
	/*	
	//tr 선택시 random 색상 칠하기
	$('.tbody tr').hover(function(){
		$(this).css({'background-color':randColor()})
	},
	function(){
		$(this).css({'background-color':'inherit'})
	});
	*/

	
	//$(window).resize();
	
});


/*$(window).resize(function(){
    $('.nonav_bodyDiv').css({position:'absloute'}).css({
        'margin-left': ($('.nonav_section').width() - $('.nonav_bodyDiv').outerWidth())/2,
        'margin-top': ($('.nonav_section').height() - $('.nonav_bodyDiv').outerHeight())/2
    });
    
    $('.nav_bodyDiv').css({position:'absolute'}).css({
    	'margin-left': $('.nav').width()+(($(window).width()/2) - $('.nav_bodyDiv').width())/2,
        'margin-top':($('.nav_section').height() - $('.nav_bodyDiv').height())/2
    });
  
    if($(window).width()>$('#wrap').outerWidth()){
    	$('#wrap').css({position:'absloute'}).css({
    	'margin-left': ($(window).width() - $('#wrap').outerWidth())/2
    	})
    
    }
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



//랜덤 색상
function getRandNum(value) {
	return Math.floor(Math.random() * (value + 1));	
}

function randColor() {
	var rgbHexadecimal = 0;

	var red = 0;
	var green = 0;
	var blue = 0;
	
	red = getRandNum(255).toString(16);
	green = getRandNum(255).toString(16);
	blue = getRandNum(255).toString(16);
	
	if(red.length < 2) 	red = "0" + red;	
	if(red.length < 2) 	green = "0" + green;
	if(red.length < 2) 	blue = "0" + blue;
	
	rgbHexadecimal = "#" + red + green + blue;
	if(rgbHexadecimal =='#FFFFFF'){
		randColor();
		return false;
	}
	
	return rgbHexadecimal;
}

function memberReportDetail(reportboardNo){
		$('#report_detail').modal();
		$.ajax({
			'url':'/udongca_project/member/memberReportDetail.udc',
			'type':'post',
			'data':{'reportboardNo':reportboardNo},
			'dataType':'json',
			'success':function(detail){
				$('#reportTitle').append(detail.reportType == 'prboard' ? '홍보글 신고' : detail.reportType = 'review' ? '리뷰 신고' : '댓글 신고');
				
				$('#memberId').append(detail.memberId);
				
				$('#reportReason').append(detail.reportContent == null ? detail.reportReason : detail.reportContent);
				
				$('#reportResult').append(detail.reportResult == null ? '처리중입니다.':detail.reportResult);
			},
			'beforeSend':function(){
				$('#reportTitle').empty();
				$('#memberId').empty();
				$('#reportReason').empty();
				$('#reportResult').empty();
				
			}
		})
	//window.open('/udongca_project/member/memberReportDetail.udc?reportboardNo='+reportboardNo,'newWin','width=400px height=610px');
}

function sessionCheck(memberId){
	if(!memberId){
		if(confirm('로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?\n(확인:로그인페이지 / 취소:메인페이지)')){
			location.href='http://192.168.0.116:4322/udongca_project/loginPage.udc';
			return false;
		}else{
			location.href='http://192.168.0.116:4322/udongca_project/main.udc';
			return false;
		}
	}
}

function themePage(page){
	$.ajax({
		"url":"/udongca_project/search/themeSearchResult.udc",
		"type":"POST",
		"data":"cafeFeature=" + $("#theme").val() + "&page=" + page,
		"dataType":"json",
		"success":function(json){
			$("#searchResult").empty();
			$(".pagination").empty();
			if (json == null || json.list.length == 0){
				$("#searchResult").append('<td colspan="3" align="center"><h3 style="color:red;">검색결과가 없습니다.</h3></td>');
				return false;
			}
			else{
				for(var i = 0; i < json.list.length; i++){
					$("#searchResult").append("<div style='margin-left:10px;margin-top:20px;padding-right: 10px;padding-top: 10px;width:200px;height:220px;float:left; text-align: center;'><a href='/udongca_project/prBoard/prView.udc?cafeNo="+json.list[i].cafeNo+"'><img style='width:200px;height:200px;' src='../images/" + json.list[i].cafeFakeImage + "'>" + json.list[i].cafeNo + "&nbsp;&nbsp;" + json.list[i].cafeName + "</a></div>");
				}
				
				
				if(json.pageBean.previousPageGroup){
					$(".pagination").append('<li><a href="#" onclick="themePage('+(json.pageBean.beginPage-1)+')">◀</a><li>');
				}else{
					$(".pagination").append('<li><a>◀</a></li>');
				}
				
				for(var idx = json.pageBean.beginPage ; idx <= json.pageBean.endPage ; idx++){
					if(idx == json.pageBean.page)
						$(".pagination").append('<li class="active"><a>'+idx+'</a></li>');
					else
						$(".pagination").append('<li><a href="#" onclick="themePage('+idx+')"> '+idx+' </a></li>');
				}

				if(json.pageBean.nextPageGroup){
					$(".pagination").append('<li><a href="#" onclick="themePage('+ ++json.pageBean.endPage +')">▶</a></li>');
				}else{
					$(".pagination").append('<li><a>▶</a></li>');
				}
			}
		}
	
	});
}

 function addressPage(submitString,page){
	$.ajax({
		"url":"/udongca_project/search/locationSearchResult.udc",
		"type":"POST",
		"data":"cafeAddress=" + submitString + "&page=" + page,
		"dataType":"json",
		"success":function(json){
			submitString = "'"+submitString+"'";
			$("#searchResult").empty();
			$(".pagination").empty();
			if (json == null || json.list.length == 0){
				$("#searchResult").append('<td colspan="3" align="center"><h3 style="color:red;">검색결과가 없습니다.</h3></td>');
				return false;
			}
			else{
				for(var i = 0; i < json.list.length; i++){
					$("#searchResult").append("<div style='margin-left:10px;margin-top:20px;padding-right: 10px;padding-top: 10px;width:200px;height:220px;float:left; text-align: center;'><a href='/udongca_project/prBoard/prView.udc?cafeNo='"+json.list[i].cafeNo+"><img style='width:200px;height:200px;' src='../images/" + json.list[i].cafeFakeImage + "'>" + json.list[i].cafeNo + "&nbsp;&nbsp;" + json.list[i].cafeName + "</a></div>");
					//$("#searchResult").append(" " + json[i].cafeNo + " " + json[i].cafeName + "<br>");
				}
				
				
				if(json.pageBean.previousPageGroup){
					$(".pagination").append('<li><a href="#" onclick="addressPage('+submitString+','+(json.pageBean.beginPage-1)+')">◀</a></li>');
				}else{
					$(".pagination").append('<li><a href="#">◀</a></li>');
				}
				
				for(var idx = json.pageBean.beginPage ; idx <= json.pageBean.endPage ; idx++){
					if(idx == json.pageBean.page)
						$(".pagination").append('<li class="active"><a>'+idx+'</a></li>');
					else
						$(".pagination").append('<li><a href="#" onclick="addressPage('+submitString+','+idx+')"> '+idx+' </a></li>');
				}
				
				if(json.pageBean.nextPageGroup){
					$(".pagination").append('<li><a href="#" onclick="addressPage('+ submitString+','+ ++json.pageBean.endPage +')">▶</a></li>');
				}else{
					$(".pagination").append('<li><a href="#">▶</a></li>');
				}
			}
		}
	});
}
 
 
 function bookmarkPage(page){
		$.ajax({
			"url":"/udongca_project/member/memberBookmarkListPaging.udc",
			"type":"POST",
			"data":"no=" + page,
			"dataType":"json",
			"success":function(json){
				
				$("#tbody").empty();
				$(".pagination").empty();
				
				if (json == null || json.list == null){
					$("#tbody").append('<td colspan="3" align="center"><h3 style="color:red;">'
							+json.error+'</h3></td>');
					return false;
				}
				else{
					for(var i = 0; i < json.list.length; i++){
						$("#tbody").append("<tr id='"+json.list[i].cafeNo+"'><td style='width: 75px; "
								+" height:40px; text-align: center'><button onclick='deleteBookmark("
								+json.list[i].cafeNo+")' class='btn btn-default' ><span class='glyphicon "
								+" glyphicon-remove'></span></button></td><td>"
								+"<a href='/udongca_project/prBoard/prView.udc?cafeNo="+json.list[i].cafeNo+"'>"
								+json.list[i].cafeName+"</a></td><td>"+json.list[i].prBoard.cafeAddress+"</td>");
					}
					if(json.pageBean.previousPageGroup){
						$(".pagination").append('<li><a href="#" onclick="bookmarkPage('
								+(json.pageBean.beginPage-1)+')">◀</a></li>');
					}else{
						$(".pagination").append('<li><a href="#">◀</a></li>');
					}
					for(var idx = json.pageBean.beginPage ; idx <= json.pageBean.endPage ; idx++){
						if(idx == json.pageBean.page)
							$(".pagination").append('<li class="active"><a>'+idx+'</a></li>');
						else
							$(".pagination").append('<li><a href="#" onclick="bookmarkPage('+idx+')"> '
									+idx+' </a></li>');
					}
				}
				if(json.pageBean.nextPageGroup){
					$(".pagination").append('<li><a href="#" onclick="bookmarkPage('
							+ ++json.pageBean.endPage +')">▶</a></li>');
				}else{
					$(".pagination").append('<li><a href="#">▶</a></li>');
				}
			}
		});
	} 
 
 
 function deleteBookmark(cafeNo){
	 if(confirm("즐겨찾기를 취소하시겠습니까?")){
		$.ajax({
			'url':'/udongca_project/member/deleteBookmark.udc',
			'type':'post',
			'data':{'cafeNo':cafeNo},
			'success':function(){
				if(this){
					alert('즐겨찾기를 해제했습니다.');
					$('#'+cafeNo).remove();
					location.reload();
				}
				else{
					alert('다시 시도해주십시오.');
				}
			}
		})
	 }
}
 
 function reviewPageGo(cafeNo,reviewNo){
	 location.href="/udongca_project/review/myReviewCafe.udc?cafeNo="+cafeNo;
 }

// UTF-8 형식 문자열 용량 측정 보조 Function
function fixedCharCodeAt(str, idx) {
	idx = idx || 0;
	var code = str.charCodeAt(idx);
	var hi, low;
	if (0xD800 <= code && code <= 0xDBFF) { // High surrogate (could change last hex to 0xDB7F to treat high private surrogates as single characters)
		hi = code;
		low = str.charCodeAt(idx + 1);
		if (isNaN(low)) {
			throw 'Invaild characters or memory error';
		}
		return ((hi - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
	}
	if (0xDC00 <= code && code <= 0xDFFF) { // Low surrogate
		// We return false to allow loops to skip this iteration since should have already handled high surrogate above in the previous iteration
		return false;
		/*hi = str.charCodeAt(idx-1);
		low = code;
		return ((hi - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;*/
	}
	return code;
}

// DB에 넣을 Data가 한도를 넘는지 알기 위해서는 문자열을 UTF-8 형식으로 용량 계산해야 함. 이를 위한 Function
// http://stackoverflow.com/questions/2848462/count-bytes-in-textarea-using-javascript
function countUtf8(str) {
	var result = 0;
	for (var n = 0; n < str.length; n++) {
		var charCode = fixedCharCodeAt(str, n);
		if (typeof charCode === "number") {
			if (charCode < 128) {
				result = result + 1;
			} else if (charCode < 2048) {
				result = result + 2;
			} else if (charCode < 65536) {
				result = result + 3;
			} else if (charCode < 2097152) {
				result = result + 4;
			} else if (charCode < 67108864) {
				result = result + 5;
			} else {
				result = result + 6;
			}
		}
	}
	return result;
}