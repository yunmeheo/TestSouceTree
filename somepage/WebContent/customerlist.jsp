<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title>customerlist.jsp</title>
</head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>

$(function(){
  
    var $parentObj = $("article");
    if($parentObj.length == 0){
      $parentObj = $("body");
    }
    
  // ★★체크했을 때 해당하는 조건의 리스트 불러오기
  /* var arrayParam = new Array();
      
    $("input:checkbox[name='searchCk']").click(function(){
      //var checkedId = $(this).attr("value");
      //$(this).prop("checked", true);
      //var arrayParam = new Array();
    
      //체크했을때 첫번째 값만 불러오기
      $("input:checkbox[name='searchCk']:checked").each(function(){
        //$("input:checkbox[name='searchCk']").prop('checked',this.checked);
    		arrayParam.push($(this).val());
    		console.log(arrayParam[0]);
    		
    	
      
      	// 다중체크 방지 - 1개씩만 가능 - 체크없애고 이동 구현해야함
       if(arrayParam.length>1){
			alert("체크는 하나까지 가능해요.");
			this.checked = false;
		}
      });
    });	 */
      	
       /* var searchCk = arrayParam[0];
        $.ajax({
           url: "selectAll.do",
           method :"POST",
           data:{
                "searchCk" : searchCk
           },
           success:function(responseData){
           var result = responseData.trim();
           if(result.msg =="-1"){
             alert("실패");
           }
           //$parentObj.empty();
           $parentObj.html(result);  
           // $(".selectById").show();
         //$(".selectAll").hide();
           
           }
         });return false;    */
         
         
    
  
  
    //★★검색하기  
    
     
   
    /* 
        var arrayParam = null;  
	$("input:checkbox[name='searchCk']").click(function(){
    	
    	var dndnd = $("input:checkbox[name='searchCk']:checked").val();
    	console.log("dndnd"+dndnd);

    	arrayParam = new Array(); 
    	$("input:checkbox[name='searchCk']:checked").each(function(){
    		
        	arrayParam.push($(this).val());
        	console.log(arrayParam[0]);
        	
        	if(arrayParam.length>1){
				this.checked = false;
				alert("체크는 하나까지 가능해요.");
		   }
    	}); 
    	
    	
    	
    });  */
    
    var arrayParam = null;  

	$("input:checkbox[name='searchCk']").click(function(){
		arrayParam = new Array(); 
    	$("input:checkbox[name='searchCk']:checked").each(function(){
        	arrayParam.push($(this).val());
    	}); 
    	if(arrayParam.length>1){
			$("input:checkbox[name='searchCk']").prop('checked', false);
			this.checked = true;
	   }
    });
	

      
    $("input[name=searchValueBt]").click(function(){ 
    	arrayParam = new Array(); 
    	$("input:checkbox[name='searchCk']:checked").each(function(){
        	arrayParam.push($(this).val());
    	}); 
        var searchItem =$("div.searchforid select").val();
        var searchValue=$("input[name=searchValue]").val();
        var searchCk = arrayParam[0];
        console.log("체크된 박스내용은 :"+searchCk);
        console.log("검색하기 클릭됨: 아이템은"+searchItem+"밸류는"+searchValue);
        
        $.ajax({
          url: "selectAll.do",
          method :"POST",
          data:{
               "searchItem" : searchItem,
               "searchValue" : searchValue,
               "searchCk" : searchCk
          },
          success:function(responseData){
          var result = responseData.trim();
          console.log("searchItem:"+searchItem+"searchValue:"+searchValue);
          
          if(result.msg =="-1"){
            alert("검색할 내용을 입력 해 주세요.");
          }
          $parentObj.empty();
          $parentObj.html(result);  
          }
        });return false;  
        
        
       });  // end click
  
  
    

     
    //★★전체고객 리스트로 돌아가기
    var $customer = $(".selectAll").find(".toselectAll");
    $customer.click(function(){
      $.ajax({
        url:"selectAll.do",
        method:"post",
        success:function(responseData){
          var result = responseData.trim();
          $parentObj.empty();
          $("article").html(responseData.trim());
        }
      }); return false;
    }); 
    
    
    //★★고객 상태변경하기
    var $modifyBt =$(".selectAlltable").find("button");
    $modifyBt.click(function(){
      console.log("data:"+$(this).attr("value")+",id:"+$(this).attr("id"));
     
      
      $.ajax({
        url :"status.do",
        method:"post",
        data: {"status": $(this).attr("value"),
             "id": $(this).attr("id") },
        success:function(responseData){
          
          var result = responseData.trim();
          //1은 삭제, -1은 관리대상처리
          if(result==1){
            alert("처리완료");
            $.ajax({
              url:"selectAll.do",
              method:"post",
              success:function(responseData){
                var result = responseData.trim();
                $parentObj.empty();
                $("article").html(responseData.trim());
              }
            }); return false;
          }else{
          alert("삭제오류");
          }
        }
      }); return false;  // end ajax
      
      
    });  // end click
    
    
         
    //전체체크 액션 
    $("input:checkbox[name='allcustomerCK']").click(function selectDelRow(){
        $("input:checkbox[name='allcustomer']").prop('checked',this.checked);
    });   
        
  	var $modifyBt =$(".customermodBt").find("button");
    $modifyBt.click(function selectDelRow(){
  	var chk = document.getElementsByName("allcustomer"); // 체크박스객체를 담는다
  	var len = chk.length;    //체크박스의 전체 개수
  	var checkRow = '';      //체크된 체크박스의 value를 담기위한 변수
  	var checkCnt = 0;        //체크된 체크박스의 개수
  	var checkLast = '';      //체크된 체크박스 중 마지막 체크박스의 인덱스를 담기위한 변수
  	var rowid = '';             //체크된 체크박스의 모든 value 값을 담는다
  	var cnt = 0;                 

  	for(var i=0; i<len; i++){
  	if(chk[i].checked == true){
  	checkCnt++;        //체크된 체크박스의 개수
  	checkLast = i;     //체크된 체크박스의 인덱스
  	}
  	} 
  	for(var i=0; i<len; i++){
  	if(chk[i].checked == true){  //체크가 되어있는 값 구분
  	checkRow = chk[i].value;
  	if(checkCnt == 1){                            //체크된 체크박스의 개수가 한 개 일때,
  	rowid += "'"+checkRow+"'";        //'value'의 형태 (뒤에 ,(콤마)가 붙지않게)
  	}else{                                            //체크된 체크박스의 개수가 여러 개 일때,
  	if(i == checkLast){                     //체크된 체크박스 중 마지막 체크박스일 때,
  	rowid += "'"+checkRow+"'";  //'value'의 형태 (뒤에 ,(콤마)가 붙지않게)
  	}else{
  	rowid += "'"+checkRow+"',";	 //'value',의 형태 (뒤에 ,(콤마)가 붙게)         			
  	}
  	}
  	cnt++;
  	checkRow = '';    //checkRow초기화.
  	}
  	   //'value1', 'value2', 'value3' 의 형태로 출력된다.
  	}
  	var allcustomerId = rowid;
  	console.log(allcustomerId); 
  	
  	$.ajax({
          url :"status.do",
          method:"post",
          data: {"status": $(this).attr("value"),
                 "id": allcustomerId },
          success:function(responseData){
            var result = responseData.trim();
            if(result==1){
              alert("처리완료");
              $.ajax({
                url:"selectAll.do",
                method:"post",
                success:function(responseData){
                  var result = responseData.trim();
                  $parentObj.empty();
                  $("article").html(responseData.trim());
                }
              }); return false;
            }else{
            alert("삭제오류");
            }
          }
     }); return false;  // end ajax
        
 });    // end $modifyBt.click	 

	
    
  //개별체크액션 = 각 체크된 아이디값 가져오기
    $("input:checkbox[name='allcustomer']").click(function(){
      var checkedId = $(this).attr("value");
      console.log(checkedId);
    });
    
    
}); //end allfunction



</script>



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

tr{
height: 20px;
}


/* 검색하기 */
div.searchforid{
margin: auto;
padding: 0px  20px  0px   0px ;
display: inline-block; 
}

div.customermodBt
{
margin: auto;
padding: 20px  0px   0px 400px;
display: inline-block; 
}

form.search{
border-radius: 3px;
display:block;
height:25px;
width:700px;
font-size: small;
}

/* 테이블 맨윗줄 상단 스타일 */
#main{
/* border: 1px dotted; */
font-family: sans-serif;
font-size: large;
background-color: #F0F8FF;
text-align:center;
height : 30px;
text-align:center;
}

.alllist{

}

button{
font-size: xx-small;
}

.selectById{display:none;}

</style>


<body>



<div class="selectAll">
<h1> 전체고객 리스트</h1>




<!-- 고객검색창 -->
  <!-- <div class="searchforid">
   <form class="search">
    <select name = "searchItem" style="height: 21px">
     <option value = "id" selected>아이디로 검색</option>
     </select> 
    <input type="search"  name="searchValue" >
    <input type="button"  name="searchValueBt"   value="검색" >
  </form>
  </div>
  <br><br> -->
  <jsp:include page="searchcheck.jsp"></jsp:include>
  
<%--  <div class="customermodBt">
 체크시 사용버튼 :
 <button class="delete" id="${customers.id}" value="delete">삭제</button>
 <button class="blackcon" id="${customers.id}" value="blackcon">관리대상</button>
 <button class="clear" id="${customers.id}" value="clear">초기화</button>
 </div> --%>
 
 <br><br>
 
 
 <!-- 고객 리스트 보여주기 -->
 <table class="selectAlltable" >
    <tr id="main">
    <td style ="width: 100px" ><label><input type="checkbox" name="allcustomerCK" value="${customers.id}" >전체체크</label></td>
    <td style ="width: 100px" >아이디</td>
    <td style ="width: 100px">비번/가입일자</td> 
    <td style ="width: 80px">이름</td> 
    <td style ="width: 80px">상태</td> 
    <td style ="width: 200px">개별변경</td> 
    </tr>  
    <c:set var="list" value="${requestScope.list}"/>
    <c:forEach  var="customers"  items="${list}" >
    
    <tr>
     <td><label><input type="checkbox" name="allcustomer" value="${customers.id}" ></label></td>
     <td class="cusId">${customers.id}</td>
     <td>${customers.password}/${customers.sign_date}</td>
     <td>${customers.name}</td>
     <td>${customers.status}</td>
     <td>
     <button class="delete" id="${customers.id}" value="delete">삭제</button>
     <button class="blackcon" id="${customers.id}" value="blackcon">관리대상</button>
     <button class="clear" id="${customers.id}" value="clear">초기화</button>
     </td>
   </tr>
  </c:forEach> 
 </table>
 
 
 <!-- 페이징 -->
 
 <%!
  public Integer toInt(String x){
    int a = 0;
    try{
      a = Integer.parseInt(x);
    }catch(Exception e){}
    return a;
  }
%>


<%Integer pageno = (Integer)request.getAttribute("pageno");
  //String strPageno = (String)(request.getAttribute("pageno"));
  //Object objpageno = request.getAttribute("pageno");
  //int pageno = Integer.parseInt(strPageno);
  if(pageno<1){//현재 페이지
    pageno = 1;
  }%>
  들어온 pageno : <%=pageno%>
  <%int total_record = pageno;      //총 레코드 수
  int page_per_record_cnt = 10;  //페이지 당 레코드 수
  int group_per_page_cnt =5;     //페이지 당 보여줄 번호 수[1],[2],[3],[4],[5] & [6],[7],[8],[9],[10]                      

  //끝점, 시작점  만약 끝점이 토탈페이지보다 클때엔 끝점은 총 글의수
  int record_end_no = pageno*page_per_record_cnt;       
  int record_start_no = record_end_no-(page_per_record_cnt-1);
  if(record_end_no>total_record){
    record_end_no = total_record;
  }
                       
                       
  int total_page = total_record / page_per_record_cnt + (total_record % page_per_record_cnt>0 ? 1 : 0);
  if(pageno>total_page){
    pageno = total_page;
  }

  

//  현재 페이지(정수) / 한페이지 당 보여줄 페지 번호 수(정수) + (그룹 번호는 현제 페이지(정수) % 한페이지 당 보여줄 페지 번호 수(정수)>0 ? 1 : 0)
  int group_no = pageno/group_per_page_cnt+( pageno%group_per_page_cnt>0 ? 1:0);
//    현재 그룹번호 = 현재페이지 / 페이지당 보여줄 번호수 (현재 페이지 % 페이지당 보여줄 번호 수 >0 ? 1:0)  
//  ex)   14    = 13(몫)   =  (66 / 5)   1 (1(나머지) =66 % 5)        
  
  int page_eno = group_no*group_per_page_cnt;   
//    현재 그룹 끝 번호 = 현재 그룹번호 * 페이지당 보여줄 번호 
//  ex)   70    = 14  * 5
  int page_sno = page_eno-(group_per_page_cnt-1); 
//    현재 그룹 시작 번호 = 현재 그룹 끝 번호 - (페이지당 보여줄 번호 수 -1)
//  ex)   66  = 70 -  4 (5 -1)
  
  if(page_eno>total_page){
//     현재 그룹 끝 번호가 전체페이지 수 보다 클 경우    
    page_eno=total_page;
//     현재 그룹 끝 번호와 = 전체페이지 수를 같게
  }
  
  int prev_pageno = page_sno-group_per_page_cnt;  // <<  *[이전]* [21],[22],[23]... [30] [다음]  >>
//    이전 페이지 번호 = 현재 그룹 시작 번호 - 페이지당 보여줄 번호수  
//  ex)   46    = 51 - 5        
  int next_pageno = page_sno+group_per_page_cnt;  // <<  [이전] [21],[22],[23]... [30] *[다음]*  >>
//    다음 페이지 번호 = 현재 그룹 시작 번호 + 페이지당 보여줄 번호수
//  ex)   56    = 51 - 5
  if(prev_pageno<1){
//    이전 페이지 번호가 1보다 작을 경우    
    prev_pageno=1;
//    이전 페이지를 1로
  }
  if(next_pageno>total_page){
//    다음 페이지보다 전체페이지 수보가 클경우    
    next_pageno=total_page/group_per_page_cnt*group_per_page_cnt+1;
//    next_pageno=total_page
//    다음 페이지 = 전체페이지수 / 페이지당 보여줄 번호수 * 페이지당 보여줄 번호수 + 1 
//  ex)        =  76 / 5 * 5 + 1  ????????    
  }
  
  // [1][2][3].[10]
  // [11][12]
%>
현재 페이지   (pageno)   : <%=pageno%><br />
전체 데이터 수   (total_record) : <%=total_record %><br />
한페이지 당 레코드 수   (page_per_record_cnt) : <%=page_per_record_cnt %><br />
한페이지 당 보여줄 페지 번호 수   (group_per_page_cnt) : <%=group_per_page_cnt %><br />

<hr />
레코드 시작 번호  (record_start_no) : <%=record_start_no%><br />
레코드 끝 번호    (record_end_no) : <%=record_end_no %><br />
전체페이지 수     (total_page)  : <%=total_page %><br />
<hr />
현재 그룹번호 [1] (group_no):  <%=group_no %><br />
현재 그룹 시작 번호(page_sno): <%= page_sno%><br />
현재 그룹 끝 번호  (page_eno): <%= page_eno%><br />
이전 페이지 번호   (prev_pageno) <%=prev_pageno%><br />
다음 페이지 번호   (next_pageno) <%=next_pageno%><br />
<hr />


<a href="pase.jsp?pageno=1">[맨앞으로]</a>
<a href="pase.jsp?pageno=<%=prev_pageno%>">[이전]</a> 
<%for(int i =page_sno;i<=page_eno;i++){%>
  <a href="pase.jsp?pageno=<%=i %>">
    <%if(pageno == i){ %>
      [<%=i %>]
    <%}else{ %>
      <%=i %>
    <%} %>
  </a> 
<%--  콤마   --%> 
  <%if(i<page_eno){ %>
    ,
  <%} %>
<%} %>
 
<a href="pase.jsp?pageno=<%=next_pageno%>" >[다음]</a>
<a href="pase.jsp?pageno=<%=total_page %>">[맨뒤로]</a>
 
 
 
 
 
 
 <c:set var="msg" value="${requestScope.msg}"/>
 <c:if test="${msg eq '1'}">
 <div class="toselectAll"
    style="height: 25px;
    width: 500px;
    background-color: #6495ED;
    font-size: large;
    color: #F0F8FF;
    margin: 10px;
    text-align: center;
    padding:10px"
    >리스트로 돌아가기</div>
</c:if> 


</div>

 

 
 
 
 
<%-- <div class="selectById">
 <h1>검색결과</h1>
 
 <table >
    <tr id="main">
    <td style ="width: 100px">아이디</td>
    <td style ="width: 100px">비번</td> 
    <td style ="width: 80px">이름</td> 
    <td style ="width: 80px">상태</td> 
    <td style ="width: 200px">변경하기</td> 
    </tr>  
    
    <c:set var="customer" value="${requestScope.c}"/>
    
    <tr>
     <td class="cusId">${customer.id}</td>
     <td>${customer.password}</td>
     <td>${customer.name}</td>
     <td>${customer.status}</td>
     <td>
     <button class="delete"  value="delete">삭제</button>
     <button class="blackcon"  value="blackcon">관리대상</button>
     <button class="clear" id="${customers.id}" value="clear">초기화</button>
     
     <!-- <input type="button" class="delete" value="삭제"   >
     <input type="button" class="blackcon" value="관리대상"> -->
     </td>
   </tr>

 </table>
 <br>
 
 </div> --%>

</body>
</html>