<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>알림</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
<script type="text/javascript">
  $(function(){ 
  
  });
</script>
 
</head> 
<body>
<div class="main_wrapper" align="center" >
  <c:import url="/menu/top.jsp"/>
  
  <c:import url="/menu/top_second.jsp"/>
  
  <DIV class='main_container' style="width: 80%;">
	  <DIV class='contents'  style="width: 100%;">  
	 
		<DIV class='title_line'>알림</DIV>
		 
		<DIV class='message'>
		  <fieldset class='fieldset_basic'>
		    <UL>
		      <c:choose>
		        <c:when test="${param.sw == 'id'}">
		          <li class='li_none'>이미 존재하는 아이디입니다.</li>
		          <li class='li_none'>다시한번 시도해주세요.</li>
		          <li class='li_none'>
		            <br>
		            <button type='button' onclick='history.back()'>다시 시도</button>
		            <button type='button' onclick="location.href='${pageContext.request.contextPath}'">취소</button>
		          </li>
		        </c:when>
		        <c:when test="${param.sw == 'create'}">
		          <c:choose>
		            <c:when test="${param.count == 0}">
		              <li class='li_none'>회원 가입에 실패했습니다.</li>
		              <li class='li_none'>다시한번 시도해주세요.</li>
		              <li class='li_none'>
		                <br>
		                <button type='button' onclick='history.back()' style="color: black;">다시 시도</button>
		                <button type='button' onclick="location.href='${pageContext.request.contextPath}'" style="color: black;">취소</button>
		              </li>
		            </c:when>
		            <c:when test="${param.count == 1 }">
		              <li class='li_none'>회원 가입에 성공했습니다.</li>
		              <li class='li_none'>
		                <br>
		                <button type='button' onclick="location.href='${pageContext.request.contextPath}/'" style="color: black;">확인</button>
		              </li>          
		 
		            </c:when>
		          </c:choose>
		        
		        </c:when>
		      </c:choose>    
		 
		    </UL>
		  </fieldset>
		 
		</DIV>
		 
		</DIV> <!-- content END -->
		
	  <div class="main_bottom">
      <c:import url="/menu/bottom.jsp"/>
    </div>
    
	</DIV> <!-- container END -->
</div>
</body>
 
</html> 
 