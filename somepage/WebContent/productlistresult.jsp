<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>   
<%@ page import="com.my.vo.Product" %> 
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>productlistresult.jsp</title>
</head>


<Style>

table td{
border: 1px dotted;
border-color : #4682B4;
border-radius: 5px;
font-family: sans-serif;
font-size: 12px;
}

/* 테이블 맨윗줄 상단 스타일 */
#main{
font-family: sans-serif;
font-size: large;
background-color: #F0F8FF;
text-align:center;
height : 30px;
text-align:center;
}

table{
width: 500px ; 
font-family: sans-serif; 
font-size: small; 
border-collapse: collapse;
text-align:center;
padding : 0px;
margin: auto;
} 

/* 모든테이블의 높이 */
table tr{
height: 23px;
}

div.detail{
border-radius: 5px;
border: 1px solide;
border-collapse: collapse; 
}

button{
/* width : 20px;
height : 10px; */
font-size: xx-small;
}


.productmodify{display: none;}


</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>

  $(function(){
    var $parentObj = $("article");
    
    if($parentObj.length == 0){
      $parentObj = $("body");
    }
    
  //상품 전체리스트
    $parentObj.on("click", "#btCart", function(){
      
      var no=$("#no").html();    // no를 찾아서 값을 가져오자. 왜 html로 가져오지
      var name=$("#name").html();
      var price=$("#price").html();
      var quantity = $("input[name=quantity]").val(); // 돔트리에서 quantity를 찾아서 값을 가져오자. 입력값이기 때문에 input태그는 val로 가져온다
      console.log(no+","+name+","+price+","+quantity);
      
      $.ajax({
        url :"addcart.do",
        mathod: "post", 
        data :{'no' :no,'name':name,'price':price,'quantity':quantity},
        success:function(responseData){
              
          alert("장바구니에 추가되었습니다.");
          $parentObj.empty(); 
        } // end success
      }); $parentObj.off(); return false; // end ajax
    });  // end button
    
    
    //상품상세리스트
    var $td = $("table td");    
    $("table td>a").click(function(){
      $.ajax({
        url:'productdetail.do',
        method:"post",
        data:{'no': $(this).html().trim()},
        success:function(responseData){
            console.log("상품번호 클릭-상세이동");
            $parentObj.empty();
            jsonObj = responseData;
            console.log(responseData)
            
            if(jsonObj == null){
              alert("정보 메이요");
            }else{
            
            var data = '<h1> 상품 상세정보 </h1>'
            data += '<table class="detail">';
            data += '<tr>'; //
            data += '<td>상품번호 :';
            data += '</td>';
            data += '<td id="no">'
            data += jsonObj.prod_no;
            data += '</td>';
            data += '</tr>'; //
            data += '<tr>'; //
            data += '<td >상품이름 :';
            data += '</td>';
            data += '<td id="name">'
            data += jsonObj.prod_name;
            data += '</td>';
            data += '</tr>'; //
            data += '<tr>'; //
            data += '<td>상품가격 :';
            data += '</td>';
            data += '<td id="price">'
            data += jsonObj.prod_price;
            data += '</td>';
            data += '</tr>';  //
            data += '</table>';
            data += '<form>';
            data += '수량:';
            data += '<input type="number" min="1" value="1" name="quantity" >'
            data += '<br>'
            data += '';
            data += ' <input type="button" id="btCart" value="장바구니넣기">'
            data += '</form>';
            $parentObj.html(data);
            }
        },
        error:function(xhr, status, error){
          console.log(xhr, status);
        }
      }); 
    return false;
  });
    
    //관리자가 상품수정 창띄우기
    $("button[name=modify]").click(function(){
      var $no=$(".productmodify").find("#prodno");
      var id=$(this).attr('id');
      console.log(id);
      console.log($no);
      $(".productmodify").show();   
      $no.html(id);
    }); 
    
    
  //취소버튼 액션
    $("input[id=cancle]").click(function(){
      $("input[id=cancle]").closest("div").hide();
    });
  
  
  
  //수정하기버튼
  var $modify = $(".productmodify").find("input[name=modify]");
  $modify.click(function(){
    console.log("상품수정하러 가융");
    var prod_no = $("#prodno").html();
    var prod_name =$("#prodName").val();
    var prod_price =$("#prodPrice").val();
    console.log("no:"+prod_no+"name:"+prod_name+"price:"+prod_price);
    
    $.ajax({
      url:"modifyProduct.do",
      data :{prod_no : prod_no,
           prod_name: prod_name,
           prod_price : prod_price },
      success:function(responseData){
        var result = responseData.trim();
        
        if(result==1){
          
          alert("수정완료");
          $.ajax({
            url:"productlist.do",
              success:function(responseData){
              $("article").html(responseData.trim());     
              }
          }); return false;
       
        }else{
          alert("입력값을 확인해주세요.");
        }
      }
    }); return false;
  });
  
    
});
</script>


<body>




<jsp:include page="productmodify.jsp"></jsp:include>

<div style ="height: 50px;margin: auto; padding: 10px"   >
<jsp:include page = "search.jsp"></jsp:include>
</div>

<div class="allprodlist">
<table>

   <c:set var="admin"  value="${sessionScope.adminLoginInfo}"/>
   <c:set var="list" value="${requestScope.list}"/>
   <tr id="main">
    <td>상품번호</td>  
    <td>상품이름</td> 
    <td>상품가격</td>
    <c:if test="${!empty admin}">
    <td>관리자${admin.id}</td>
    </c:if>
   </tr>    
   
   <c:forEach var="product"  items="${list}">
    <tr>
    <td><a href = "#">${product.prod_no}</a></td> 
    <a href ="productdetail.do?no=${product.prod_no}"></a>
    <td>${product.prod_name}</td> 
    <td>${product.prod_price}</td>
    
    <c:if test="${!empty admin}">
    <td><button name="modify" id="${product.prod_no}">상품수정</button>&nbsp;</td>
    </c:if>
    </tr>  
   
   </c:forEach>
   
   
</table>
</div>
</body>
</html>
















