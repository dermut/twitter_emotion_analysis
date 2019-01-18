<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Tea</title>
 
<link href="./css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com  /bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(function(){
 
  });
</script>
</head> 
 
</head>
<body>
<FORM name='frm' id='frm' method='GET' action='../member_word/wordno_by_member.do' >
    <div class="form-group">
      회원 별 검색어번호 목록
      <input type="hidden" name="memberno" value="<%=(Integer)session.getAttribute("memberno")%>">
    </div>
    <button type="submit">조회</button>
</FORM>

<%-- 수정 요망 여기 만들 차례 검색어 별 회원 목록 
<FORM name='frm' id='frm' method='GET' action='../member_word/member_by_wordno.do' >
    <div class="form-group">
      특정 검색어를 검색한 회원 목록
      <input type="hidden" name="wordno" value="<%=(Integer)session.getAttribute("memberno")%>">
    </div>
    <button type="submit">조회</button>
</FORM>
 --%>
 


입력한 검색어 : ${word}<br>
wordno : ${wordno}<br>
memberno : ${memberno }<br>
수정본
<DIV class='bottom_menu'>
  <button type='button' onclick="location.href='../'">돌아가기</button>
  
</DIV> 
</body>
</html>