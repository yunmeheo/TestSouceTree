<%@page import="com.my.vo.Admin"%>
<%@page import="com.my.vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>



<style>
div a{
font-size: small;
font-style: normal;

}
</style>

<!-- 포함될 페이지 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>

  $(function(){
    
    var $header =$("header");
    var $a =$header.find("a");
      $a.click(function(){
                  
        var url = $(this).attr("href");
        $.ajax({url: url,
            method: 'GET', 
            success:function(responseData){
            if(url =="logout.do"){
              location.href=responseData.trim();
            }else if(url=="admin.jsp"){
              location.href=url;
            }else{
              $("article").empty();
              //응답받는 data로 채우기
                $("article").html(responseData.trim()); 
            } 
          }
        }); // end ajax
        return false;
      });   //end click
  });
  
</script>

<style>

.menu{
margin :auto;
background-color: #6495ED;
padding : 50px  0px   0px   0px;
text-align:right;
height : 30px;
font-size: large;
}

.menu a{
text-decoration: none; 
color: #F0F8FF;
font-weight:bold;
}

.menu a:hover{ color: #666666; text-decoration: none; }

</style>

<div class="menu">
<!-- 만약 받아온 데이터에 키값:loginInfo(밸류는 costomer 정보임) 가 null이면 (로그인전임)-->


 
 <%Customer c = (Customer)session.getAttribute("loginInfo");
 %>
 
 <% Admin a = (Admin)session.getAttribute("adminLoginInfo");
    if(a!=null){%>
      <a href ="admin.jsp">관리자홈</a>&nbsp;&nbsp;
      <%}else{%>
 
 
  <%if(c == null){
  %>
    <a href ="adminloginform.jsp" 
    style="font-size: xx-small;
    text-align: left;">관리자로그인</a>&nbsp;&nbsp;
    
    <a href="signupform.html">가입</a> &nbsp;&nbsp;
    <a href="loginform.jsp">로그인</a> &nbsp;&nbsp;
  <%}else{%>
    <a href ="logout.do">로그아웃</a>&nbsp;&nbsp;
    <%}%>
    <a href="productlist.do">상품목록</a> &nbsp;&nbsp;
    <a href ="cartlist.do">장바구니보기</a>&nbsp;&nbsp;
    
    <%}%>
    <a href ="repboardlist.do">문의게시판</a>&nbsp;&nbsp;
    
    
    
    <%-- <%if("adm".equals(c.getId())){%>
  
   <a href ="logout.do">회원관리</a>&nbsp;&nbsp;
   <a href ="logout.do">상품관리</a>&nbsp;&nbsp;
   <a href ="logout.do">게시판관리</a>&nbsp;&nbsp;
   
  <%} --%>
  
  
    
  
 
  
  
  
</div>
