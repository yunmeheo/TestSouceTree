<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>

<meta content="text/html; charset=UTF-8">
<title>modifycustomer.jsp</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>

 $(function(){
	 var $maininfo = $("div.maininfo");
	 var $modCus = $("div.modcus");
	 var $mod = $(".maininfo").find(".mod");
	 
	 
	//정보보기
	 $mod.click(function(){
	 location.href="customerdetail.jsp";	 
	 }); 
	 
	 
	<%-- //수정하기
	 	$(".maininfo").find("input[id=modcus]").click(function(){
	 		$(".modcus").show();
		});
		var nowpwd=$(".modcus").find("input[name=nowpwd]");
	 	var newpwd1=$(".modcus").find("input[name=newpwd1]");
	 	var newpwd2=$(".modcus").find("input[name=newpwd2]");
	 	newpwd1.focus(function(){
			$("input[id=modcus]").hide();
		});	
	 	newpwd2.focus(function(){
	 		if(newpwd1.val()==newpwd2.val()){
	 			$("input[id=modcus]").show();
	 		}
		});	
	 	
	 	
	 	
	 	$("input[id=modcus]").click(function(){
	 		console.log($(".maininfo").find(".id").html());
	    	$.ajax({
	    		url:"cusmodify.do",
	    		method:'POST',
	    		data :{"id": $(".maininfo").find(".id").html(),
	    			    "nowpwd" :  nowpwd.val(),
	    			    "newpwd1" : newpwd1.val(),
	    			    "newpwd2" : newpwd2.val()
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
	 
	 	//취소버튼 액션
	    $("input[id=cancle]").click(function(){
	    	$("input[id=cancle]").closest("div").hide();
	    }); --%>
	 
	 
 }); // end function



</script>


<style>
div.maininfo{
border: 1px solid;
padding: 1px;
font-size: xx-small;
height: 30px;
text-align: right;
}

/* div.modcus{
height: 320px;
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

div.modcus{display:none;} */
</style>

<body>
<!-- 본인 비밀번호 확인 후 개인정보 변경할 것 -->
  <%-- <c:set var="loginInfo" value="${sessionScope.loginInfo}"/>
  <c:if test="${loginInfo != null}">
  <!-- $divModcus.show(); -->
  <jsp:include page = "modifycustomer.jsp"></jsp:include>
  </c:if> --%>
  
  
  
  <!-- 보여지는 고객정보창 -->
  <div class="maininfo">
  안녕하세요<h3 style="margin: 0px; font-size: 20px; color: blue; display: inline-block;">${loginInfo.name}</h3>님.
  <%-- 이름 : <span class="name">${loginInfo.name}</span> --%>
  아이디 :<span class="id">${loginInfo.id}</span>
  <%--   비밀번호 :<span class="password">${loginInfo.password}</span><br> --%>
  <span class="mod" style="border: 1px solid;font-size:small; ;">나의정보</span>&nbsp;
  </div>
  
  
  <%-- <!-- 띄워지는 고객정보창 -->
  <div class="modcus">
  <h3>고객정보</h3>
  이름 : ${loginInfo.name}<br>
  아이디 : ${loginInfo.id}<br>
  비밀번호 : ${loginInfo.password}<br>
  
  <form method="post">
   <!-- <h3>비밀번호 변경</h3>
      안전한 비밀번호로 내정보를 보호하세요<br>
   
      현재 비밀번호 : <input name="nowpwd" type="text" placeholder="기존 비밀번호를 입력"><br>
      새로운 비밀번호 : <input name="newpwd1" type="text" placeholder="새 비밀번호를 입력"><br>
      새로운 비밀번호 확인 : <input name="newpwd2" type="text" placeholder="새 비밀번호 다시한번 입력">--><br> 
   <input type="button" value="수정" id="modcus">
   <input type="button" value="탈퇴" id="delete">
   <input type="button" value="취소" id="cancle">
   
  </form>
  </div> --%>
  
</body>

