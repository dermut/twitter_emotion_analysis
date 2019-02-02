<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
   
<script type="text/javascript">
  $(function(){

  });
</script>

</head> 

<body>
<div class="login_root">
  <div class="login" style="width: 40%;">
	  <DIV class='message'>
	    <H3>정보가 일치합니다.</H3>
	    <H3>찾으시려는 아이디는 ${id} 입니다.</H3>
	    <BR><BR>
	  </DIV>
	  
	  <div class="form-group">
	    <button type="button" onclick="location.href='/tea'" class="btn btn-primary btn-md">홈으로</button>
      <button type="button" onclick="location.href='./login.do'" class="btn btn-primary btn-md">로그인</button>
	  </div>

  </DIV> <!-- login END -->
</DIV> <!-- login_root END -->
</body>

</html> 

