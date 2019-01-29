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
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
 
  <div class='menu_line'></div>
  
 
  <table class="table table-striped" style='width: 100%; text-align: center;'>
  <caption>로그인 내역</caption>
  <colgroup>
    <col style='width: 5%;'/>
    <col style='width: 5%;'/>
    <col style='width: 20%;'/>
    <col style='width: 15%;'/>
    <col style='width: 10%;'/>
  </colgroup>
  <TR >
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
  <br><br>
  

 <DIV>
  <button type='button' onclick="location.href='../'">돌아가기</button>
  
</DIV> 
  
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>