<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title>check.jsp</title>
</head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>

/* $(function(){
  
  var $searchCk= $(".searchforid").("input[type=checkbox]");  // .attr('name');  delete
  
  $searchCk.click(function(){
	  
	  $.ajax({
		  url:
			  
			  
			  
	  });return false; 
  });
 });*/ 
  


</script>




<body>



<!-- 전체체크,  탈퇴회원,  관리회원, 일반회원 -->

<!-- 고객검색창 -->
  <div class="searchforid">
   <form class="search">
    <select name = "searchItem" style="height: 21px">
     <option value = "id" selected>아이디로 검색</option>
     <option value = "name" selected>이름으로 검색</option>
     </select> 
    <input type="search"  name="searchValue" >
    <input type="button"  name="searchValueBt"   value="검색" >
    
    <label><input type="checkbox" name="searchCk" value="delete" >탈퇴회원</label>
    <label><input type="checkbox" name="searchCk" value="blackcon" >관리회원</label>
    <label><input type="checkbox" name="searchCk" value="clear" >일반회원</label>
    
  </form>
  </div>
  <br><br>

 <div class="customermodBt">
 
 일괄처리:
 <button class="delete" id="${customers.id}" value="delete">삭제</button>
 <button class="blackcon" id="${customers.id}" value="blackcon">관리대상</button>
 <button class="clear" id="${customers.id}" value="clear">초기화</button>
   
 </div>
 
 
 
 
 
</body>
</html>