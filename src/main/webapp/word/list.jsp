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
 
<!--   <ASIDE style='float: left;'>
      <A href='./word/list.do'>검색어 목록</A>  
  </ASIDE> -->
 
  <div class='menu_line'></div>
  
 
  <table class="table table-striped" style='width: 100%; text-align: center;'>
  <caption>검색어 목록</caption>
  <colgroup>
    <col style='width: 20%;'/>
    <col style='width: 30%;'/>
    <col style='width: 30%;'/> 
    <col style='width: 20%;'/>
  </colgroup>
  <TR >
    <TH class='th'>번호</TH>
    <TH class='th'>검색어</TH>
    <TH class='th'>등록일</TH>
    <TH class='th'>기타</TH>
  </TR>
 
  <c:forEach var="wordVO" items="${list }">
    <c:set var="wordno" value ="${wordVO.wordno }" /> 
  <TR>
    <TD class='td'>${wordno}</TD>
    <TD class='td'>${wordVO.word}</A></TD>
    <TD class='td'>${wordVO.rdate.substring(0, 10)}</TD> <!-- 년월일 -->
    <TD class='td'></TD>
    
  </TR>
  </c:forEach>
  
</TABLE>
 
<DIV class='bottom_menu'>
  <button type='button' onclick="location.href='../'">돌아가기</button>
  
</DIV> 
 
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>