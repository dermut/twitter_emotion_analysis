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
<!-- 있어야 하는 것 -> 회원 별 검색어번호 목록-->
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
 
  <ASIDE style='float: left;'>
      <A href='./member_word/wordno_by_member.do'>회원 별 검색어번호 목록</A>  
  </ASIDE>
 
  <div class='menu_line'></div>
  
 
  <table class="table table-striped" style='width: 100%; text-align: center;'>
  <caption>회원 별 검색어번호 목록</caption>
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 20%;'/>
    <col style='width: 30%;'/>
    <col style='width: 40%;'/> 
  </colgroup>
  <TR >
    <TH class='th'>번호</TH>
    <TH class='th'>회원 번호</TH>
    <TH class='th'>검색어</TH>
    <TH class='th'>기타</TH>
  </TR>
 
  <c:forEach var="word_memberwordVO" items="${list }">
    <c:set var="mwno" value ="${word_memberwordVO.mwno }" /> 
  <TR>
    <TD class='td'>${mwno} </TD>
    <TD class='td'>${word_memberwordVO.memberno}</TD>
    <TD class='td'>${word_memberwordVO.word}</TD>
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