<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title>writeresult.jsp</title>
</head>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>

  $(function(){
    
    var $header =$("header");
    var $a =$header.find("a");
      $a.click(function(){
                  
        var url = $(this).attr("href");
        $.ajax({url: url
            
              $("article").empty();
              //응답받는 data로 채우기
                $("article").html(responseData.trim()); 
            
          
        }); // end ajax
        return false;
      });   //end click
  });
  
</script>










<style>
/* 디테일테이블 */

div.detail {
margin: auto;
display: inline-block;
}   
.detail table{
width: 500px ; 
font-family: sans-serif; 
font-size: small; 
border-collapse: collapse;
text-align:center;
padding : 50px;
}  

/* 모든테이블 안에 칸막이 설정*/
table td{
border: 1px dotted;
border-color : #4682B4;
border-radius: 5px;
font-family: sans-serif;
font-size: 12px;
}


/* 모든테이블 안에 칸막이 설정*/
table td{
border: 1px dotted;
border-color : #4682B4;
border-radius: 5px;
font-family: sans-serif;
font-size: 12px;
}


</style>


<body>

<header>
<jsp:include page="menu.jsp"></jsp:include>
</header>

<%-- ${requestScope.Content} --%>

<div class="detail">

<c:set  var="content"  value="${requestScope.Content}"/>

<c:forEach var="repboard" items="${content}">

 <table>
  <tr style="background-color: #F0F8FF">
  <td style="width: 50px" >글번호</td>
  <td >제목</td>
  </tr>
  <tr>
  <td class="no">${repboard.no}</td>
  <td class="subject" >${repboard.subject}</td>
  </tr>
  <tr>
  <td >파일번호 </td>
  <td  class="filename" colspan="2" style="height : 10px ; padding : 0px ;"> ${repboard.filename}</td>
  </tr>
  <tr>
  <td  class="content" colspan="2" style="height : 500px ; padding : 0px;">${repboard.content}</td>
  </tr>
  </table>
  
  <form class="forword" style="padding : 10px">
  <h5 style="display: inline; width: 30px"> 작업</h5>
    <select name="selectItem"> 
    <option value="update" >수정 </option> 
    <option value="delete" >삭제 </option> 
    <option value="reply" >답글달기 </option>
    </select> 
   <input type="button" id="forwordBt" value="확인">
   <input type="button" id="listBt" value="목록보기">
  </form>
</div>  
  

</c:forEach>



</body>
</html>