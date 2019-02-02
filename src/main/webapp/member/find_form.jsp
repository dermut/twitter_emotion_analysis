<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>아이디/비밀번호 찾기</title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript" src="../js/jquery.cookie.js"></script>

</head> 

<body>
  
<div class="login_root">
  <div class="login">
		
		  <FORM name='frm' method='GET' action='./find_id.do'>
		     <!-- 아이디 찾기 div -->
		    <div class="form-group">
		      <label for="id" class="col-sm-3 control-label" style="padding: 0px 3px 3px 3px;">이름</label>    
	        <input type='text' class="col-sm-9 form-control" name='name' id='name' value='' required="required" placeholder="이름" autofocus="autofocus">        
	      </div>
	      
	      <div class="form-group">
		      <label for="id" class="control-label" style="padding: 0px 3px 3px 3px;">이메일</label>    
	        <input type='text' class="form-control" name='email' id='email' value='' required="required" placeholder="이메일" autofocus="autofocus">
	      </div>
      </FORM>
		    
	     <!-- 아이디 찾기 버튼 -->
	     <div class="form-group" style="text-align: center;">
	       <button type="submit" class="btn btn-primary btn-md">아이디 찾기</button>
		   </div>  
		
		  <FORM name='frm' method='GET' action='./find_passwd.do'>
		     <!-- 비밀번호 찾기 div -->
		    <div class="form-group">
		      <label for="id" class="control-label" style="padding: 0px 3px 3px 3px;">아이디</label>    
	        <input type='text' class="form-control" name='id' id='id' value='' required="required" placeholder="아이디">
        </div>
        
        <div class="form-group">
		      <label for="name" class="control-label" style="padding: 0px 3px 3px 3px;">이름</label>
	        <input type='text' class="form-control input-md" name='name' id='name' value='' required="required" placeholder="이름">
	      </div>  
	      
	      <div class="form-group">
		      <label for="email" class="control-label" style="padding: 0px 3px 3px 3px;">이메일</label>
	        <input type='text' class="form-control input-md" name='email' id='email' value='' required="required" placeholder="이메일">
		    </div>   
		    
	      <!-- 비밀번호 찾기 버튼 -->
        <div class="form-group" style="text-align: center;">
          <button type="submit" class="btn btn-primary btn-md">비밀번호 찾기</button>
        </div>  
      </FORM>
		
      <!-- 버튼 -->
	    <div class="form-group" style="text-align: center;">
        <button type="button" onclick="location.href='./create.do'" class="btn btn-primary btn-md">회원가입</button>
        <button type="button" onclick="history.back()" class="btn btn-danger btn-md">취소</button>
	    </div>   

	</DIV> <!-- container END -->
</div>
</body>

</html> 
 
 
 