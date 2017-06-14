<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>productmodify.jsp</title>
</head>




<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>


</script>



<body>


<div class="productmodify">
            
  <form class="modifysubmit" method="post">
  <!--  상품번호 :<input class="prodno" id="no"  type="text" maxlength="4"><br> -->
   상품번호 :<span id="prodno" style="border-color: white; "></span><br>
   상품명    :<input id="prodName"  type="text" placeholder ="상품명 입력" maxlength="20"><br>
   가격       :<input id="prodPrice"  type="text" placeholder ="상품 가격 입력"  maxlength="55"><br>
   <input name="modify"  type="button" value="수정하기">
   <input id="cancle" type="button" value="취소하기">
  </form>
            
</div>

</body>
</html>