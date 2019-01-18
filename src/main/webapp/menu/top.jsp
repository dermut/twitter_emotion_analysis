<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>TOP</title>

<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">

</head>
<body>
<div class="top_container">
  
    <ul class="sites">
      <li class="site">
        <a href="${pageContext.request.contextPath}"><img alt="TEA Home Logo" src="${pageContext.request.contextPath}/image/home.png"></a>
      </li>
    </ul>
      
	  <ul class="login_list">
	    <li class="login">
		    <c:choose>
	        <c:when test="${sessionScope.grade == null}">
	          <button type="button" class="login_button" id="login" name="login" onclick="location.href='${pageContext.request.contextPath}/member/login.do'">로그인</button>
	        </c:when>
	        <c:otherwise>
	          <div style="color:white; display: inline;">○ 접속한 아이디: </div>
	          <div style="color:white; font-weight: bold; display: inline;">${sessionScope.id } &nbsp&nbsp | &nbsp&nbsp</div>
	          <button class="login_button" type="button" class="logout_button" id="logout" name="logout" onclick="location.href='${pageContext.request.contextPath}/member/logout.do'">로그아웃</button>
	        </c:otherwise>
		    </c:choose>
	    </li>
    </ul>
  </div>
</body>
</html>