<%@ page  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title>addadminform.jsp</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<script>
$(function(){
    var $id = $('input[name=id]');
    var $submit =$('input[type=submit]');
    var $button =$('button');
    $form = $('form');
    
    //id input란에 커서를 놓으면 가입버튼사라짐
    $id.focus(function(){
      $submit.hide();
    }); 
    
    
    //중복검사버튼 - 가입버튼 생성 
    $button.click(function(){
      console.log("중복버튼 클릭");
      
      //아이디 중복체크 서블릿 checkid.do 로 연산요청 
      $.ajax({ 
      url : 'admcheckid.do',
      method : 'POST',
      data : {"id": $('input[name=id]').val()},
      success : function(responseData){  
        
          console.log("아이디체크성공은 1 : "+responseData);
          var result = responseData.trim();  
          // -1은 중복
          if(result == "1"){
            alert("사용가능합니다.");
            $submit.show()
          }else if(result == "-1"){
            alert("사용할 수 없는 ID입니다.");
          }
          
      },
      error : function(xhr, status, error){
        console.log("errorData:" + status+","+ error);
      }
    }); return false;  // end ajax
    });  // end button

    
    
    //★총★  가입버튼 이벤트   
    $form.submit(function(){  
      
      var $id = $('input[name=id]');
      var $pwd = $('input[name=pwd]');
      var $pwd1 = $('input[name=pwd1]');
      var $name = $('input[name=name]');
      var $submit =$('input[type=submit]');
      
      //$form.attr("action","signup.do");
        //입력한 가입버튼 두개가 다를경우 실패  
          if($pwd.val()!=$pwd1.val()){
            alert('비밀번호가 다릅니다.');
            return false;
          };
      
      //id와 비밀번호, 이름으로 로그인 하기
      var $data=$form.serialize();
      
      console.log($data);
      $.ajax({ 
          url : "adminsignup.do",
          method : 'POST',
          data : $data,
          success : function(responseData){  
            var result = responseData.trim();  
            if(result == '1'){
              console.log("가입하기 클릭됨");
              alert('성공');
            }else{
              alert(result);
              console.log("가입실패");
            }
            
            },
          error : function(xhr, status, error){
            console.log("errorData:" + status+","+ error);
          }
        }); return false;  // end ajax
      });  // end submit
    
    
  //취소버튼 액션
    $("input[id=cancle]").click(function(){
    	console.log("취소클릭");
    	<%-- location.href = "<%=contextPath%>"; --%>
    	$("input[id=cancle]").closest("div").hide();
    });
      
    
    
  });
</script>



<style>

.signup{
border: 1px solid;
display: inline-block;
margin: auto;
padding : 0px;
width:380px;
height: 210px;
position: absolute; 
top:200px; 
background-color: white;
} 

/* .infobox{
border: 1px solid;
border-color: #6495ED;
display: inline-block;
width:380px;
height: 50px;
background-color: #6495ED;
box-sizing: border-box;
text-align: center;
padding : 12px;
font-size: large;
color: #F0F8FF;
font-weight:bold;
}  */

.signup form{
padding : 10px;
}

.signup h5{
display: inline-block ;
width: 95px;
height: 20px;
margin: 0px;
}

</style>

<body>

<div class="signup" >
  <div class="infobox" style="padding:10px; font-weight: bold; font-size: large;">관리자 추가하기</div>
  <form method = "post">
    <h5>ID :</h5>           <input  type = "text"  name ='id' required>&nbsp; <button> 중복확인</button><br>
    <h5>비밀번호: </h5>      <input type = "password" name ="pwd"><br>
    <h5>비밀번호 확인 :</h5> <input type = "password" name ="pwd1"><br>
    <h5>NAME: </h5>          <input type = "text" name ="name" ><br>
    <h5>우편번호 :</h5>      <div class = "zip"></div> 
    
   <!-- <button>가입하기</button>  -->
   <!-- 유효성 검사하려면 type 속성에 submit 으로 변경 해야 함 -->
   
   <input style="position:static; right: 10px ; "  type='submit' value = '추가'>
   <input type='button' id="cancle" value = '취소'>
  </form>
</div>



</body>
</html>