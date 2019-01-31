<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 
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
    <DIV class='contents'>   
	 
	  <div class='menu_line'></div>
	  
	 
		<table class="table table-striped table-hover" style='background-color: #F9F9F9; text-align: center; box-shadow: 5px 5px 10px gray;'>
		  <caption style="color: white; padding: 20px 0px 20px 0px;">로그인 내역</caption>
		  <colgroup>
		    <col style='width: 5%;'/>
		    <col style='width: 5%;'/>
		    <col style='width: 20%;'/>
		    <col style='width: 15%;'/>
		    <col style='width: 10%;'/>
		  </colgroup>
		  
		  <TR>
		    <TH class='th'>번호</TH>
		    <TH class='th'>회원 번호</TH>
		    <TH class='th'>IP</TH>
		    <TH class='th'>로그인 날짜</TH>
		    <TH class='th'>성공 여부</TH>
		  </TR>
		 
		  <c:forEach var="logVO" items="${list }">
		    <c:set var="logno" value ="${logVO.logno }" /> 
		  <TR>
		    <TD class='td'>${logno}</TD>
		    <TD class='td'><A href="../member/read.do?memberno=${logVO.memberno}">${logVO.memberno}</A></TD>
		    <TD class='td'>${logVO.ip}</TD> <!-- 등급 -->
		    <TD class='td'>${logVO.rdate.substring(0, 19)}</TD>
		    <TD class='td'>${logVO.sf}</TD>   
		  </TR>
		  </c:forEach>
		
		</TABLE>
		  
	   <DIV class='bottom_menu_paging'>${paging }</DIV>
	 
	 </DIV> <!-- content END -->
	 
	  <div class="main_bottom">
      <c:import url="/menu/bottom.jsp"/>
    </div>
    
	</DIV> <!-- container END -->

</div>
</body>
 
</html>