<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Tea</title>
 
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
 
</head>
<body>

<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

  <div class='menu_line'></div>
  
 
  <table class="table table-striped" style='width: 100%; text-align: center;'>
  <caption>검색어 동향 단순 리스트(개발 편의용)</caption>
  <colgroup>
    <col style='width: 25%;'/>
    <col style='width: 25%;'/>
    <col style='width: 25%;'/>
    <col style='width: 25%;'/> 
  </colgroup>
  <TR >
    <TH class='th'>번호</TH>
    <TH class='th'>검색어 번호</TH>
    <TH class='th'>빈도</TH>
    <TH class='th'>등록시간</TH>
  </TR>
 
  <c:forEach var="wordTimeGraphVO" items="${list }">
    <c:set var="word_time_no" value ="${wordTimeGraphVO.word_time_no }" /> 
  <TR>
    <TD class='td'>${word_time_no}</TD>
    <TD class='td'>${wordTimeGraphVO.wordno}</TD>
    <TD class='td'>${wordTimeGraphVO.freq}</TD> 
    <TD class='td'>${wordTimeGraphVO.rdate}</TD>
    
  </TR>
  </c:forEach>
  
</TABLE>
 
<DIV class='bottom_menu'>
  <button type='button' onclick="location.href='../index.do'">돌아가기</button>
  
</DIV> 
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
</html>