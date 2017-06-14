<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title>customerdetail.jsp</title>
</head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>


$(function(){
	
	
	//수정하기버튼 눌리면 수정창 띄우기
 	$(".modinfo").find("input[id=modcus]").click(function(){
 		$(".modcus").show();
	});
	
	
	var nowpwd=$(".modcus").find("input[name=nowpwd]");
	var nowpwd1=$(".modcus").find("input[name=nowpwd1]");
 	var newpwd1=$(".modcus").find("input[name=newpwd1]");
 	var newpwd2=$(".modcus").find("input[name=newpwd2]");
 	var newname1=$(".modcus").find("input[name=newname1]");
 	var newname2=$(".modcus").find("input[name=newname2]");
 	
 	//비밀번호 동일한지 확인작업
 	newpwd1.keyup(function(){
 		$("input[id=modpwdbt]").hide();
	});	
 	
 	newpwd2.keyup(function(){
 		if(newpwd1.val()==newpwd2.val()){
 			$("input[id=modpwdbt]").show();
 		}else if(newpwd1.val()!=newpwd2.val()){
 			$("input[id=modpwdbt]").hide();
 		}
	});
 	

 	
 	 /* id = modnamebt modpwdbt */
	
 	//최종 수정하기 누르면 수정완료! 
    $("button[name=modbt]").click(function(){
    		console.log($(".modinfo").find(".id").html());
    	$.ajax({
    		url:"cusmodify.do",
    		method:'POST',
    		data :{"id": $(".modinfo").find(".id").html(),
    			   "name": $(".modinfo").find(".name").html(),
    			    "nowpwd" :  nowpwd.val(),
    			    "nowpwd1" :  nowpwd1.val(),
    			    "newpwd1" : newpwd1.val(),
    			    "newpwd2" : newpwd2.val(),
    			    "newname1" : newname1.val(),
    			    "newname2" : newname2.val(),
    			    "value":$(this).attr('value')
    			    },
    		    success:function(responseData){
    			var result = responseData.trim();
    			if(result==1){
    				alert("수정완료");
    				location.href="<%=contextPath%>";
    			}else{
    				alert("정확히 입력해주세요");
    			}
    		}
    				
    	}); return false;
    }); 
 	
 	//상태변경 = 탈퇴하기  <button class="delete"  value="delete">탈퇴</button>
    var $modifyBt =$(".modinfo").find(".delete");
  	var id = $(".modinfo").find(".id").html();
  	
  	
  	
  	$modifyBt.click(function(){
  		//console.log("data:"+$(this).attr("value")+",id:"+id);
  		console.log("탈퇴하기 클릭!");
  		alert("정말 탈퇴하실건가요?");
  		
  		$.ajax({
  			url :"status.do",
  			method:"post",
  			data: {"status": $(this).attr("value"),
  				   "id": id },
  			success:function(responseData){
  				
  				var result = responseData.trim();
  				if(result==1){
  					alert("탈퇴완료! 다음에 다시만나요.");
  					
  					location.href="<%=contextPath%>";
  					
  				}
  			}
  		}); return false;  // end ajax
  	});  // end click
 	
 	   
    //홈버튼 액션
    $("input[id=home]").click(function(){
    	location.href = "<%=contextPath%>";
    	//$("input[id=cancle]").closest("div").hide();
    });
  	
   //취소버튼 액션
    $("input[id=cancle]").click(function(){
    	console.log("취소클릭");
    	<%-- location.href = "<%=contextPath%>"; --%>
    	$("input[id=cancle]").closest("div").hide();
    });
   
   
   //클릭시 주문상품 보여주기
    $(".viewListBt").click(function(){
    	var id = $(".modinfo").find(".id").html();
    	console.log(id);
    	$.ajax({
            url:"statistics.do",
            method:"post",
            data :{"stat":$(this).attr("value"), 
					"id":id       	
              },
            success:function(reseponseDate){
            	$(".customerorderlist").show();
            	$(".customerorderlist").html(reseponseDate);
            }
        }); return false;  
	});
  	

}); // end function

</script>
<style>
/* div.modinfo{
border: 1px solid;
padding: 1px;
font-size: xx-small;
height: 30px;
text-align: right;
} */

div.modcus{
height: 350px;
width: 350px;
border: 1px solid;
padding: 10px;
position: absolute; 
top:200px; 
left: 100px;
background-color: white;
border-color: #6495ED;
padding: 30px;
}

div.modcus{display:none;}
div.customerorderlist{display:none;}
div.statistics{display:none;}
</style>





<body>


  <header>
  <jsp:include page = "modifycustomer.jsp"></jsp:include>
  <jsp:include page = "menu.jsp"></jsp:include>
  </header>

<article>

  
  <c:set var="loginInfo" value="${sessionScope.loginInfo}"/>
  
  
  <!-- 고객정보 페이지 -->
  <div class="modinfo">
  <h3>고객정보</h3>
  이름 : <span class="name">${loginInfo.name}</span><br>
  아이디 : <span class="id">${loginInfo.id}</span><br>
  비밀번호 : <span class="password">${loginInfo.password}</span><br>
  
  <form method="post">
  <br> 
   <input type="button" value="수정" id="modcus">
   <button class="delete"  value="delete">탈퇴</button>
   <input type="button" value="홈으로" id="home">
  </form>
  
  </div>
  
  <br>
  
  
  <!-- 클릭시 주문상품 보여주기 -->
  <h3>주문한 물품</h3>
  <button class="viewListBt" value="customer">주문상품 보기</button><br><br>
  <div class="customerorderlist">
  </div>
  
  

  <div class="modcus">
  
  <form method="post">
  <h3>이름 변경</h3>
  
      새로운 이름 : <input name="newname1" type="text" placeholder="새 이름 입력"><br>
      새로운 이름 확인 : <input name="newname2" type="text" placeholder="새 이름 다시한번 입력"><br>
      현재 비밀번호 : <input name="nowpwd" type="text" placeholder="현재 비밀번호 입력"><br>
      <button value="modnamebt" name="modbt">이름 수정하기</button>
      <!-- <input type="button" value="수정하기" id="modbt">
      <input type="button" value="취소" id="cancle"> -->
  
  <h3>비밀번호 변경</h3>
      안전한 비밀번호로 내정보를 보호하세요<br>
   
      현재 비밀번호 : <input name="nowpwd1" type="text" placeholder="기존 비밀번호 입력"><br>
      새로운 비밀번호 : <input name="newpwd1" type="text" placeholder="새 비밀번호 입력"><br>
      새로운 비밀번호 확인 : <input name="newpwd2" type="text" placeholder="새 비밀번호 다시한번 입력"><br>
      <button value="modpwdbt" name="modbt">비밀번호 수정하기</button><br><br>
     
      <input type="submit" value="취소" id="cancle">
   </form>
  </div>
  
  

</article>
  <footer></footer>

</body>
</html>