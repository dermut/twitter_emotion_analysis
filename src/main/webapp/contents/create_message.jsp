<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
    
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
			        <c:when test="${param.count == 1 }">
			          <LI class='li_none'>새로운 컨텐츠를 등록했습니다.</LI>
			        </c:when>
			        <c:otherwise>
			          <LI class='li_none'>새로운 컨텐츠 등록에 실패했습니다.</LI>
			        </c:otherwise>
			      </c:choose>
			      <LI class='li_none'>
			        <br>
			        <button type='button' onclick="location.href='./create.do?boardno=${param.boardno}'">새로운 컨텐츠 등록</button>
			        <button type='button' onclick="location.href='./list_by_board_search_paging.do?boardno=${param.boardno}'">목록</button>
			      </LI>
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

   