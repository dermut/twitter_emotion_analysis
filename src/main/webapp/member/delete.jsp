<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
</head> 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
 
  <ASIDE style='float: left;'>
      <A href='./member/list.do'>회원 목록</A> > 회원 삭제 
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./list.do'>목록</A>
  </ASIDE> 
 
  <div class='menu_line'></div>
<DIV class='title_line'>회원 삭제</DIV>
 
<DIV class='content' style='width: 500px; text-align: center;'>
  <FORM name='frm' method='POST' action='./delete.do'>
    '${memberVO.name }(${memberVO.id })' 회원을 삭제하면 복구 할 수 없습니다.<br><br>
    정말로 삭제하시겠습니까?<br><br>         
    <input type='hidden' name='memberno' value='${memberVO.memberno }'>     
        
    <button type="submit">삭제</button>
    <button type="button" onclick="location.href='./list.do'">취소(목록)</button>
 
  </FORM>
</DIV>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 