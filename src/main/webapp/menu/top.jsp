<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <A class='menu_link'  href='${pageContext.request.contextPath}/login/login_list.do'>로그인 내역</A> <span class='top_menu1'> | </span>

    <c:choose>
        <c:when test="${sessionScope.grade == null}">
          <button type="button" class="login_button" id="login" name="login" onclick="location.href='${pageContext.request.contextPath}/member/login.do'">로그인</button>
        </c:when>
        <c:otherwise>
          ${sessionScope.id } <button type="button" class="logout_button" id="logout" name="logout" onclick="location.href='${pageContext.request.contextPath}/member/logout.do'">로그아웃</button>
        </c:otherwise>
      </c:choose>
    
  </div>
</div>
</body>
</html>