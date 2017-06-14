<%@ page contentType="text/html; charset=UTF-8"%>
<% String contextPath=request.getContextPath();%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminloginform.jsp</title>
</head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
  $(function(){
	  var $parentObj = $("article");
		
		if($parentObj.length == 0){
			$parentObj = $("body");
		}
	  
	  
    var $subObj = $("input[type=submit]");
    var $form = $("form");
    var url = 'adminLogin.do';
    var itemValue = localStorage.getItem("saveId");
    
    if(itemValue != null){
       $("input[name=id]").val(itemValue);
    }

    
    $subObj.click(function(){
      var $id = $('input[name=id]').val();
      var $pwd = $('input[name=pwd]').val();
      console.log($id);
      console.log($pwd);
      
      //체크박스가 선택됐을 때
      //window.localStorage.setItem()  -- 쿠키대신해서 저장
      //window.localStorage.setItem("storageId",$("input[name=id]")).val(); 
  
      if($("input[name=c]").prop("checked") == true){
        localStorage.setItem("saveId", $("input[name=id]").val()); 
      }else{
        localStorage.removeItem("saveId");
      }
    
    
      $.ajax({ 
          url: url,        // 어디서 받아올건지
          method: 'POST',      //ajax 전송방식 (받아오는통신)
          data: $form.serialize(),
            success: function(responseData){
             var data = responseData.trim();
             if(data =="1"){
               alert("로그인성공");
               
               //로그인 성공시 페이지를 기본페이지로 돌아오게 하자.
               <%-- location.href = "<%=contextPath%>";
               $("div.adminindex").show(); --%>
               location.href="admin.jsp";
               
             }else if( data =="-1"){
               alert("로그인실패");
             }else{
               alert(data);
             }
         }
         //기본이벤트핸들러처리를 막기위해 return작업을 꼭 해야함.
       });return false; 
     });  // end clickfunction
   });  // end allfunction
 
 
</script>

<style>

.login{
border: 1px solid;
border-color: #6495ED;
border-radius: 3px;
display: inline-block;
margin: auto;
padding : 0px;
width:360px;
height: 120px;
position: absolute; 
top:200px; 
}

.login form{
padding : 7px;
}

div.loginbox{
border: 1px solid;
border-color: #6495ED;
display: inline-block;
width:360px;
height: 50px;
background-color: #6495ED;
box-sizing: border-box;
text-align: center;
padding : 12px;
font-size: large;
color: #F0F8FF;
font-weight:bold;
}


.login h5{
display: inline-block;
width: 70px;
height: 20px;
margin: 0px
}

</style>

<body>
<div class="login" >
  <div class="loginbox">관리자로그인</div>
 <form>  <!--  아무것도 없으면 get방식이고, action 속성이 없으면 빈값을 준것과같다. -->
   <h5> 아이디:</h5>     <input type ="text" name="id" >
                         <input type ="checkbox" name="c"><h5>id저장</h5><br>
   <h5> 비밀번호 : </h5> <input type ="password" name="pwd" >
    <input type = "submit" value = "로그인">
 </form>
</div> 





</body>
</html>