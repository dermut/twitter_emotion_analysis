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
<div class="main_wrapper community_wrapper--index">
  <div class="top">
    <c:import url="/menu/top.jsp"/>
  </div>
  
  <div class="top_second">
    <c:import url="/menu/top_second.jsp"/>
  </div>
  
  <div class="main_container">
    <div class="contents" align="center">
 
      <div class="member_aside" >
        <ASIDE style='float: left; padding:15px 0px 15px 0px;'>
            <A href='./member/list.do' style="font-weight: bold; color: white;">회원 목록</A>  
        </ASIDE>
        <ASIDE style='float: right; padding: 15px 0px 15px 0px;'>
          <A href="javascript:location.reload();" style="font-weight: bold; color: white;">새로고침</A>
          <span class='menu_divide' >│</span> 
          <A href='./create.do' style="font-weight: bold; color: white;">회원 가입</A>
          <span class='menu_divide' >│</span> 
          <A href='./list.do' style="font-weight: bold; color: white;">목록</A>
        </ASIDE> 
      </div>
      
	    <div class='menu_line'></div>
	  
	 
		  <table class="table table-striped table-hover" style='background-color: #F9F9F9; width: 100%; text-align: center;'>
		  <colgroup>
		    <col style='width: 10%;'/>
		    <col style='width: 10%;'/>
		    <col style='width: 35%;'/>
		    <col style='width: 35%;'/>
		    <col style='width: 10%;'/>
		  </colgroup>
		  
		  <TR>
		    <TH>번호</TH>
		    <TH>회원 번호</TH>
		    <TH>IP</TH>
		    <TH>로그인 날짜</TH>
		    <TH>성공 여부</TH>
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
 
 
    </DIV> <!-- content END -->
  <jsp:include page="/menu/bottom.jsp" flush='false' />
  </DIV> <!-- container END -->
</div>
</body>
 
</html>