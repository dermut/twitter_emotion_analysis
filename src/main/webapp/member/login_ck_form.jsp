<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>로그인</title> 

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
	
	  <FORM name='frm' method='POST' action='./login.do'>
		  <div class="form-group">
		    <label for="id" class="control-label" style="padding: 0px 3px 3px 3px;">아이디</label>    
	      <input type='text' class="form-control" name='id' id='id' value='<%--${ck_id }--%>root3' required="required" placeholder="아이디" autofocus="autofocus">
	      <input class="form-check-input" type='checkbox' name='id_save' value='Y' ${ck_id_save == 'Y' ? "checked='checked'" : "" } style="margin: 10px 2px 2px 5px;"> 저장
		  </div>   
			<div class="form-group">
			  <label for="passwd" class="control-label" style="padding: 0px 3px 3px 3px;">패스워드</label>    
		    <input type='password' class="form-control" name='passwd' id='passwd' value='<%-- ${ck_passwd }--%>1234' required="required" placeholder="패스워드">
	      <input class="form-check-input" type='checkbox' name='passwd_save' value='Y' ${ck_passwd_save == 'Y' ? "checked='checked'" : "" } style="margin: 10px 2px 2px 5px;"> 저장
			</div>   
			<div class="form-group" style="text-align: center;">
		    <button type="submit" class="btn btn-primary">로그인</button>
		    <button type="button" onclick="history.back()" class="btn btn-danger">취소</button>
		  </div>
	
	</FORM>
	        
  </div> <!-- login end -->
</div> <!-- root end -->

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html> 
 
 
 