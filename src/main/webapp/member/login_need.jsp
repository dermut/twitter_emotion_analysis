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
<div class="main_wrapper" align=center>
  <c:import url="/menu/top.jsp"/>
  
  <c:import url="/menu/top_second.jsp"/>
  <DIV class='main_container' style='width: 80%;'>
  
  <DIV class='content'>
	  <DIV class='message' style="color: white">
	    <H3>로그인이 필요한 페이지입니다.</H3>
	    <BR><BR>
	    [<A href='${pageContext.request.contextPath}/member/login.do' style="color: white;">로그인</A>]
	    [<A href='${pageContext.request.contextPath}/member/create.do' style="color: white;">회원 가입</A>]
	  </DIV>

  </DIV> <!-- content END -->
    <div class="main_bottom">
      <c:import url="/menu/bottom.jsp"/>
    </div>
  </DIV> <!-- container END -->
</div>
</body>

</html> 

