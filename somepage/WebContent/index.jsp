<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!--   시멘틱테그 header 는   <div id = "header">  =  <header>   동일하게 사용가능하다 -->

  <header>
  
  <c:set var="loginInfo" value="${sessionScope.loginInfo}"/>
  <c:if test="${loginInfo != null}">
  <jsp:include page = "modifycustomer.jsp"></jsp:include>
  </c:if>
  
  <jsp:include page = "menu.jsp"></jsp:include>
  </header>
  
  
  <article>
  
  
  
  <jsp:include page = "home.jsp"></jsp:include>
  
  
  </article>
  <footer></footer>
</body>
</html>