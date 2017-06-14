<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<a href="modeltest4.do">다음페이지</a>
<div style="background-color: yellow; font-size: small;">
<h3>세션속성</h3>
<%
/* Enumeration<String> iterater = request.getAttributeNames(); */
Enumeration<String> sessioniterater = session.getAttributeNames(); 
while(sessioniterater.hasMoreElements()){
   /* 모든 모델의 어트리뷰트의 키 : 밸류를 가지고 오자 */ 
   /* 이 열거된 개체의 다음 요소가 하나 이상의 요소를 가지고 있는 경우 이 열거된 다음 요소를 반환합니다.  */
   String attrName = sessioniterater.nextElement(); 
   Object attrValue = request.getAttribute(attrName);
   %>   
   <%=attrName%> :  <%=attrValue%>  <br>

<%}%>
</div>

<div style="background-color: gray;font-size: small">
<h3>요청속성</h3>
<%
/* Enumeration<String> iterater = request.getAttributeNames(); */
Enumeration<String> iterater = request.getAttributeNames(); 
while(iterater.hasMoreElements()){
   /* 모든 모델의 어트리뷰트의 키 : 밸류를 가지고 오자 */ 
   /* 이 열거된 개체의 다음 요소가 하나 이상의 요소를 가지고 있는 경우 이 열거된 다음 요소를 반환합니다.  */
   String attrName = iterater.nextElement(); 
   Object attrValue = request.getAttribute(attrName);
   %>   
   <%=attrName%> :  <%=attrValue%>  <br>

<%}%>
</div>