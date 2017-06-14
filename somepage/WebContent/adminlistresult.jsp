<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>adminlistresult.jsp</title>
</head>




<style>
table{
border-radius: 5px;
border: 1px solide;
border-collapse: collapse; 
}

table td{
border: 1px dotted;
border-color : #4682B4;
border-radius: 5px;
font-family: sans-serif;
font-size: 12px;
text-align:center;
}

#main{
font-family: sans-serif;
font-size: large;
background-color: #F0F8FF;
text-align:center;
height : 30px;
text-align:center;
}


td{
height: 20px;
}

.selectAll{
margin:20px;
}
</style>




<body>
<h1>관리자 list</h1>
<div class="selectAll">
<table>
<tr id="main">
<td style ="width: 100px">아이디</td>
<td style ="width: 100px">이름</td>
<td style ="width: 100px">비밀번호</td>
<td style ="width: 100px">수정</td>
</tr>

<c:set var="list"  value="${requestScope.list}"/>
<c:forEach var="admin" items="${list}">
<tr>
<td>${admin.id}</td>
<td>${admin.name}</td>
<td>${admin.password}</td>

<c:choose>
<c:when test="${admin.id eq 'admin'}">
<td><button>수정-수정중</button></td>
</c:when>
<c:otherwise>
<td>최고관리자에게 문의하세요</td>
</c:otherwise>
</c:choose>


</tr>
</c:forEach>

</table>
</div>




</body>
</html>