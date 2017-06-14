<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri ="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title>validtestform.jsp</title>
</head>
<body>
                              <!-- 커맨드 객체의 이름 @ModelAttribute("c")설정하면 viewer에서도 쓸 수 있음 -->
  <form:form action="validtest.do" commandName="c">   <!-- spring form태그는 default로 post요청방식을 사용함 -->
    ID: <input type="text" name = "id"> <form:errors path="id"/><br>  <!-- 에러가 발생될 필드값 String field = "id" -->
    NAME : <input type = "text" name = "name"><br>
    <input type ="submit" value="전송">
  </form:form>

</body>
</html>