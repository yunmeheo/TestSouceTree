<% String contextPath=request.getContextPath();%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%-- <%@ attribute name="best" required="true" type="java.lang.boolean"%> --%>


<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title>statisticslistresult.jsp</title>
</head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">


//통계보내기

  $(function(){
  
    var $parentObj = $("article");
        if($parentObj.length == 0){
          $parentObj = $("body");
        }
        
        
    
    
    
    var $stat = $(".statistics").find("li");
    $stat.click(function(){
        var stat = $(this).attr("class");
        console.log(stat);      
        $.ajax({
          url:"statistics.do",
          method:"post",
          data :{"stat":stat  
            },
          success:function(reseponseDate){
            $parentObj.empty();
            $parentObj.html(reseponseDate);
            
          }
        }); return false;  
    }); // end clickfunction
    
    
  
        // menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
       /*  $(".li_table").find("li.col").click(function(){
              
            var submenu = $(this).next("ul");
            // submenu 가 화면상에 보일때는 위로  접고 아니면 아래로 펼치기
            if(submenu.is(":visible") ){
                submenu.slideUp();
            }else{
                submenu.slideDown();
            }
        }); */
  
        /* $(".li_table").find("li.col").click(function(){
          var id= $(".li_table").find("li.col").attr('id');
          console.log("접기클릭");  
            // 현재 클릭한 태그가 a 이기 때문에
            // a 옆의 태그중 ul 태그에 hide 클래스 태그를 넣던지 빼던지 한다.
            
            if($(this).attr('id').is($(this).next('ul').children().attr('id')){
            $(this).next("ul").toggleClass("hide");
            }
            
        }); */
            
            /* $("ul").click(function(){
                $("li").toggle();
             }); */
            
            
             
      $("ul.parent").click(function(){
        
        $(this).find(".child").toggle();
          var best= $(this).attr('id');
              console.log("best :"+best);
              
               /* 
               var list1 = new Array();
               list1.push(best);
               alert("${list1[0]}");
               <c:forEach items="${list_map}" var="item1"> */
               /* </c:forEach> */
          /* $.ajax({
                url:"statistics.do",
                method:"post",
                data :{"best":best}
              }); return false;   */
              
      });
             
             
             
             
             
             
           //alert($(this).find(".child").html());
           //$("<img src ='best.png'>").appendTo(".hide child:first-child");
        //var best= $(".bestClick").attr('id');
             /* var div = $("<div class='listdetail'>").appendTo(".seatlist");
        div.html(jsonObj[i].seat_no); */
             
            // $("body").on("click", ".listdetail", function(){
             
             /* $(".hide child:first-child").click(function(){
        console.log("자식클릭");
      }); */
      
  });


</script>

<style>


 
.li_table{ display:block;  width:400px; border:1px solid #4682B4; border-top:none;border-bottom:none; border-right:none;}
.li_table ul{clear:left;  margin:0px; padding:0px;  list-style-type:none; border-top:1px solid #4682B4; }
.li_table ul.subject {font-weight:bold; text-align:center;}
.li_table ul li{width:97px ;text-align:center; float: left; margin:0px; padding: 2px 1px; border-right:1px solid #4682B4; }
.statistics li{text-decoration: underline; cursor:pointer;  font-size: small; }
/* .li_table ul li.col{width:98.5px; list-style-type:none;} */
ul.show{display:block;}
ul.hide{display: none;}
</style>

<body>

<div class = statistics>
<ul>
<li class="customer">고객별 많이 주문한 물품 - 주문건 1개일때 상세클릭 안됨 수정 예정</li>
<li class="product">상품별 많이 주문한 고객들</li>
<li class="daily">일자별 가장 많이 주문된 상품</li>
</ul>
</div>

<div class="li_table">


<c:set var="stat" value="${requestScope.stat}"/>  
    <ul class="subject"> 
    <c:if test="${'daily' eq stat}">
    <li class ="col">주문일자</li> 
    <!-- <li>주문자ID</li> -->
    </c:if>
    
    <c:if test="${'customer' eq stat}">
    <li class ="col">주문자ID</li>
    </c:if>
    
    <li class ="col">주문상품번호</li>
    <li>상품이름</li>
   
    <c:if test="${'product' eq stat}">
    <li>주문자ID</li>
    </c:if>
    <li>상품수량</li>
    </ul>
    
    <!-- ★★ 고객별 통계 -->
    <c:if test="${'customer' eq stat}">
    <c:set var="list" value="${requestScope.list}"/>
       
       <c:forEach var="map"  items= "${list}" varStatus="status">   
         <c:choose>
         <c:when test="${empty map['LINE_PROD_NO']}"><!-- 상품번호가 없으면 -->
          <!-- status.index가 0보다 크면-->
         <c:if test="${status.index > 0}">
           </ul>
         </c:if>
         <!-- 총 행수가 1이상이라면 출력 -->
         <ul class="show parent" id='${status.index}'><!-- 하위태그 -->   
         <!-- 가장 아래 총계출력하기 -->
         <li style="<c:if  test="${empty map['ID']}"> color : red;">
         총 판매량</c:if><c:if  test="${!empty map['ID']}">">${map['ID']}</c:if></li>
         <!--만약 아이디의 값이 같을 경우 -->
         <!-- 번호가 없을경우    --님의통계-- 출력-->
         <li  style="<c:if  test="${empty map['LINE_PROD_NO']}"> color : red;">
        상세보기</c:if><c:if  test="${!empty map['LINE_PROD_NO']}">">${map['LINE_PROD_NO']}</c:if></li>
         <li > :${map['PROD_NAME']} </li>
         <li> ${map['SUM']} </li>
         </c:when>
         
         
         <c:otherwise>
         <!-- 하위내용출력하기 -->
         <ul class="hide child">  
         
         
         
         
         <!--총계출력하기 -->
         <li style="<c:if  test="${empty map['ID']}"> color : red;">
         총 판매량</c:if><c:if  test="${!empty map['ID']}">">${map['ID']}</c:if></li>
         <!--만약 아이디의 값이 같을 경우 -->
         
        <%--  ${status.index+1}
          <img src ='best.png'>
          class="show parent" id='${status.index}' --%>
          
         <li style="<c:if  test="${empty map['LINE_PROD_NO']}"> color : red;">
         ${map['ID']}님의 통계</c:if><c:if  test="${!empty map['LINE_PROD_NO']}">">${map['LINE_PROD_NO']}</c:if></li>
         
         
         <c:set var="best" value="${requestScope.best}"/>
         <li><!--  ${status.index}-->
         <c:choose>
         <c:when test="${status.index}==${status.index}">
         <img src ='best.png'>${map['PROD_NAME']} 
         </c:when>
         <c:otherwise>
         <img src ='best.png'>${map['PROD_NAME']} 
         </c:otherwise>
         </c:choose>
         </li>
         
         <li>${map['SUM']} </li>
          
         
         </ul>
         </c:otherwise>
       </c:choose>             
     </c:forEach> 
    </c:if> 
    
    
    
    <!-- ★★ 상품별 통계 -->
     <c:if test="${'product' eq stat}">
     <c:forEach var="orderInfo"  items= "${list}" varStatus="status"> 
     <c:forEach var="orderLine"  items= "${orderInfo.lines}" > 
        <c:choose>
          <c:when test="${empty orderLine.line_prod_no.prod_name}"><!-- 상품번호가 없으면 -->
           <!-- status.index가 0보다 크면-->
          <c:if test="${status.index > 0}">
            </ul>
          </c:if>
          <%-- lines : ${status.index} --%>
          <!-- 총 행수가 1이상이라면 출력 -->
          <ul class="show parent"><!-- 하위태그 -->   
          <!-- 가장 아래 총계출력하기 -->
          <%-- <li>${orderLine.line_prod_no.prod_no}</li> --%>
          <li style="<c:if  test="${empty orderLine.line_prod_no.prod_no}"> color : red;">
          총 판매량</c:if><c:if  test="${!empty orderLine.line_prod_no.prod_no}">">${orderLine.line_prod_no.prod_no}</c:if></li>
          <!--만약 아이디의 값이 같을 경우 -->
          <!-- 번호가 없을경우    --님의통계-- 출력-->
          <li style="<c:if  test="${empty orderLine.line_prod_no.prod_name}"> color : red;">
          상세클릭</c:if><c:if  test="${!empty orderLine.line_prod_no.prod_name}">">${orderLine.line_prod_no.prod_name}</c:if></li>
          <li> :${orderInfo.info_c.id}</li>
          <li> ${orderLine.line_quantity}</li>
          </c:when>
          <c:otherwise>
         
         <!-- 하위내용출력하기 -->
          <ul class="hide child">  
                        
          <!--총계출력하기 -->
          <li>${orderLine.line_prod_no.prod_no}</li>
           
         <!--만약 아이디의 값이 같을 경우 -->
         <li>${orderLine.line_prod_no.prod_name}</li>
         <li><img src ='best.png'>${orderInfo.info_c.id} </li>
         <li>${orderLine.line_quantity} </li>
         
         </ul>
        </c:otherwise>
       </c:choose>        
      </c:forEach>  
     </c:forEach> 
    </c:if>   
    
   <!-- ★★ 일자별 통계 -->
   <c:if test="${'daily' eq stat}">
   
    
    
   <c:forEach var="orderInfo"  items= "${list}" varStatus="status"> 
   
   <ul class="show parent">
   
   
   <li class ="col"><fmt:formatDate value="${orderInfo.info_date}" pattern="yyyy-MM-dd"/> </li>
   
   
   
 
   <c:choose>
   <c:when test="${fn:length(orderInfo.lines)>1}">  
   
        <li>${orderLine.line_prod_no.prod_no}</li>
        <li> ${orderLine.line_prod_no.prod_name}</li>
        <li> ${orderLine.line_quantity}</li>
        
    <c:forEach var="orderLine"  items= "${orderInfo.lines}" begin="1"  end="${fn:length(orderInfo.lines)}">
         
        <li>${orderLine.line_prod_no.prod_no}</li>
        <li> ${orderLine.line_prod_no.prod_name}</li>
        <li> ${orderLine.line_quantity}</li>
      </c:forEach>    
   </c:when> 
     
   
   <c:otherwise>
  	 <c:forEach var="orderLine"  items= "${orderInfo.lines}" begin="0"  end="${fn:length(orderInfo.lines)}"> 
        
        <li>${orderLine.line_prod_no.prod_no}</li>
        <li> ${orderLine.line_prod_no.prod_name}</li>
        <li> ${orderLine.line_quantity}</li>
     </c:forEach>   
   </c:otherwise>
   </c:choose>  
   
    
   
   
        <%-- <li class ="col"></li>
        <li>${orderLine.line_prod_no.prod_no}</li>
        <li> ${orderLine.line_prod_no.prod_name}</li>
        <li> ${orderLine.line_quantity}</li> --%>
        
       
   
        
        
        
     
       
   
   
   </ul> 
   
      
    
   </c:forEach> 
   
   
   
   
   
<%-- <table width ="700px" >

<h5>주문 고맙습니다.</h5><br>
<h3>소중한 고객님의 주문내역 입니다.</h3>
  <tr id="main">
  <td>주문번호</td>
  <td>주문일자</td>
  <td>상품번호</td>
  <td>상품명</td>
  <td>상품가격</td>
  <td>수량</td>
  <td>금액</td>
  </tr>
   
   
   <c:set var="list" value="${requestScope.list}"/>
  <!-- 인포for -->
      <c:forEach var="orderInfo"  items= "${list}" > 
     <tr>
      <td rowspan ="${fn:length(orderInfo.lines)}">${orderInfo.info_no} </td>
      <td rowspan ="${fn:length(orderInfo.lines)}"><fmt:formatDate value="${orderInfo.info_date}" pattern="yyyy-MM-dd"/></td> 
        <c:forEach var="orderLine"  items= "${orderInfo.lines}" > 
        <td>${orderLine.line_prod_no.prod_no} </td>
        <td>${orderLine.line_prod_no.prod_name} </td>
        <td>${orderLine.line_prod_no.prod_price}</td>
        <td>${orderLine.line_quantity} </td>
        <td>${orderLine.line_quantity*orderLine.line_prod_no.prod_price} </td>
        </tr> 
        </c:forEach> 
     </c:forEach> 
  </table> 
    --%>
   
   
   
   
   
   
   
   
   
   
   
   
   <%-- <c:forEach var="orderInfo"  items= "${list}" varStatus="status"> 
   <c:forEach var="orderLine"  items= "${orderInfo.lines}" > 
      <c:choose>
        <c:when test="${empty orderLine.line_prod_no.prod_no}"><!-- 상품번호가 없으면 -->
        <c:if test="${status.index > 0}">
          </ul>
        </c:if>
        <ul class="show parent"><!-- 하위태그 -->   
        <li class ="col"><fmt:formatDate value="${orderInfo.info_date}" pattern="yyyy-MM-dd"/> </li>
        <li style="<c:if  test="${empty orderLine.line_prod_no.prod_no}"> color : red;">
        상세클릭</c:if><c:if  test="${!empty orderLine.line_prod_no.prod_no}">">${orderLine.line_prod_no.prod_no}</c:if></li>
        <li> :${orderLine.line_prod_no.prod_name}</li>
        <li> ${orderLine.line_quantity}</li>
        </c:when>
        <c:otherwise>
       <!-- <ul class="hide child"> -->
       <ul class="hide child"  style="<c:if  test="${empty orderLine.line_prod_no.prod_no}"> display:none;"></c:if>
       <c:if  test="${!empty orderLine.line_prod_no.prod_no}">"></c:if>
       <li><fmt:formatDate value="${orderInfo.info_date}" pattern="yyyy-MM-dd"/></li>
       <li>${orderLine.line_prod_no.prod_no}</li>
        
       <c:if test="">${status.index}
       <li><img src ='best.png'> ${orderLine.line_prod_no.prod_name} </li>
        
       <li>${orderLine.line_quantity} </li>
       
       </ul>
      </c:otherwise>
     </c:choose>        
    </c:forEach>  
   </c:forEach>  --%>
  </c:if> 
    
  <ul></ul>
</div>   
       
       
       
       
<%--      <c:forEach var="map"  items= "${list}" varStatus="status">        
         <c:choose>
         <c:when test="${empty map['LINE_PROD_NO']}"><!-- 상품번호가 없으면 -->
         ${ status.index }                  
           <c:if test="${status.index > 0}">
             </div>
           </c:if>
           <div class="show parent"><!-- 하위태그 -->   
            <c:if test="${'customer' eq stat}">
           ${map['ID']}
            <!--만약 아이디의 값이 같을 경우 -->
           </c:if>
         : ${map['LINE_PROD_NO']}
         : ${map['LINE_PROD_NAME']} 
         : ${map['SUM']} 
         </c:when>
         <c:otherwise>
           <div class="hide child">  
            <c:if test="${'customer' eq stat}">
           ${map['ID']}
            <!--만약 아이디의 값이 같을 경우 -->
           </c:if>
         : ${map['LINE_PROD_NO']}
         : ${map['LINE_PROD_NAME']} 
         : ${map['SUM']} 
         </div>
         </c:otherwise>
         </c:choose>             
     </c:forEach>  --%>
    
   <%--  <c:forEach var="orderInfo"  items= "${list}" > 
    
    
    
    
    <ul class="statmenu" > 
      
      <c:if test="${'daily' eq stat}">
       <li class ="col"><fmt:formatDate value="${orderInfo.info_date}" pattern="yyyy-MM-dd"/> </li>
      <li>${orderInfo.info_c.id}</li>
      </c:if>
      
      <c:if test="${'customer' eq stat}">
       <li class ="col" id="${orderInfo.info_c.id}">${orderInfo.info_c.id}</li>
      <!--만약 아이디의 값이 같을 경우 -->
      </c:if>
       
          <c:forEach var="orderLine"  items= "${orderInfo.lines}" > 
          
          <li>${orderInfo.lines[0].line_prod_no.prod_no} </li>
          <li>${orderInfo.lines[0].line_prod_no.prod_name} </li>
          
          <c:if test="${'product' eq stat}">
           <li class ="col">${orderInfo.info_c.id}</li>
          </c:if>
          
          <li>${orderInfo.lines[0].line_quantity} </li>
          </c:forEach> 
          </ul>
          
       </c:forEach> 
       
       <ul> 
     </ul> --%>


</body>
</html>