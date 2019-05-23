<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>TOP SECOND</title>

<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

</head>
<body>
<div class="top_second_container">
  <div class="navbar-collaspe collaspe" style="margin-left: 100px;">
    <ul class="nav navbar-nav navbar-left">
    
      <li class="top_second_nav_button">
        <a class="top_second_font" href ="${pageContext.request.contextPath}" style="padding: 12px 12px 12px 12px;"> 홈</a>
      </li>
      
        <c:choose>
          <c:when test="${sessionScope.grade.equals('A')}"> <!-- 회원등급이 관리자라면 -->  
            <li class="top_second_nav_button">
              <A class="top_second_font" href='${pageContext.request.contextPath}/categrp/list.do' style="padding: 12px 12px 12px 12px;">카테고리 그룹</A>
            </li>
          </c:when>         
          <%-- <c:when test="${sessionScope.grade == null}"> <!-- 비로그인 상태 -->  
            <li class="top_second_nav_button">
              <a class="top_second_font" href='${pageContext.request.contextPath}/member/login_need.do' style="padding: 12px 12px 12px 12px;">카테고리 그룹</a>
            </li>
          </c:when>          --%>
        </c:choose>               

        <c:choose>
          <c:when test="${sessionScope.grade.equals('A')}"> <!-- 회원등급이 관리자라면 -->  
            <li class="top_second_nav_button">
              <A class="top_second_font" href='${pageContext.request.contextPath}/board/list.do' style="padding: 12px 12px 12px 12px;">게시판 목록</A>
            </li>
          </c:when>         
          <%-- <c:when test="${sessionScope.grade == null}"> <!-- 비로그인 상태 -->  
            <li class="top_second_nav_button">
              <a class="top_second_font" href='${pageContext.request.contextPath}/member/login_need.do' style="padding: 12px 12px 12px 12px;">게시판 목록</a>
            </li>
          </c:when>          --%>
        </c:choose>     

        <c:choose>
          <c:when test="${sessionScope.grade.equals('A')}"> <!-- 회원등급이 관리자라면 -->  
            <li class="top_second_nav_button">
              <A class="top_second_font" href='${pageContext.request.contextPath}/member/list.do' style="padding: 12px 12px 12px 12px;">회원 목록</A>
            </li>
          </c:when>         
          <%-- <c:when test="${sessionScope.grade == null}"> <!-- 비로그인 상태 -->  
            <li class="top_second_nav_button">
              <a class="top_second_font" href='${pageContext.request.contextPath}/member/login_need.do' style="padding: 12px 12px 12px 12px;">회원 목록</a>
            </li>
          </c:when> --%>          
          <%--<c:otherwise>  <!-- 로그인 상태 -->      
             <li class="top_second_nav_button">
              <A class="top_second_font" href='${pageContext.request.contextPath}/member/list.do' style="padding: 12px 12px 12px 12px;">회원 목록</A>
            </li> 
          </c:otherwise>--%>
        </c:choose>

        <c:choose>
          <c:when test="${sessionScope.grade == null}"> <!-- 비로그인 상태 -->  
            <li class="top_second_nav_button">
              <a class="top_second_font" href='${pageContext.request.contextPath}/member/login_need.do' style="padding: 12px 12px 12px 12px;">로그인 내역</a>
            </li>
          </c:when>
          <c:otherwise>  <!-- 로그인 상태 -->        
            <li class="top_second_nav_button">
              <A class="top_second_font" href='${pageContext.request.contextPath}/login/login_list_paging.do?memberno=${sessionScope.memberno}' style="padding: 12px 12px 12px 12px;">로그인 내역</A>
            </li>
          </c:otherwise>
        </c:choose>
        
<%--       <c:forEach items="${board_list }" var="menu">
         <li class="top_second_nav_button">
           <a class="top_second_font" href='${pageContext.request.contextPath}/contents/list_by_board_search_paging.do?boardno=<c:out value="${menu.boardno}"/>' style="padding: 12px 12px 12px 12px;"><c:out value="${menu.name }"/></a>
         </li>
      </c:forEach> --%>
      <c:forEach items="${board_list }" var="menu">
      <c:choose>
          
           <c:when test="${menu.boardno == 1}"> <!-- boardno가 1일때 -->  
              
           </c:when>
           <c:otherwise>  <!-- 2부터 -->        
            <li class="top_second_nav_button">
              <a class="top_second_font" href='${pageContext.request.contextPath}/contents/list_by_board_search_paging.do?boardno=<c:out value="${menu.boardno}"/>' style="padding: 12px 12px 12px 12px;"><c:out value="${menu.name }"/></a>
            </li>
           </c:otherwise>
        
      </c:choose>
      </c:forEach>
    </ul>
  </div>
</div>
</body>
</html>