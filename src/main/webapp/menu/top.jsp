<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>TOP</title>
</head>
<body>
<div class="container">
  <div class="top_right">
    <A class='menu_link'  href='${pageContext.request.contextPath}/categrp/list.do'>카테고리 그룹</A> <span class='top_menu1'> | </span>
    <A class='menu_link'  href='${pageContext.request.contextPath}/board/list.do'>카테고리 목록</A> <span class='top_menu1'> | </span>
    <A class='menu_link'  href='${pageContext.request.contextPath}/member/list.do'>회원 목록</A> <span class='top_menu1'> | </span>
    <button type="button" class="login_button" id="login" name="login">로그인</button>
  </div>
</div>
</body>
</html>