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

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(function(){ 
  
  });
</script>

</head> 
<body>
<div class="main_wrapper" align=center>
  <c:import url="/menu/top.jsp"/>
  <c:import url="/menu/top_second.jsp"/>
  
	<DIV class='main_container' style="width: 80%;">
		<DIV class='contents' align="center">
		
		<DIV class='title_line'>알림</DIV>
		
		<DIV class='message'>
		  <fieldset class='fieldset_basic'>
		    <UL>
		      <c:choose>
		        <c:when test="${param.count == 0}">
		          <li class='li_none'>글 삭제에 실패했습니다.</li>
		          <li class='li_none'>다시한번 시도해주세요.</li>
		          <li class='li_none'>
		            <br>
		            <button type='button' onclick='history.back()' style="color: black;">다시 시도</button>
		            <button type='button' onclick="location.href='./list_by_board.do?boardno=${param.boardno}&word=${param.word }&nowPage=${param.nowPage }'" style="color: black;">목록</button>
		          </li>
		                     
		        </c:when>
		        <c:when test="${param.count == 1}">
		          <li class='li_none'>글 삭제에 성공했습니다.</li>
		          <li class='li_none'>
		            <br>
		            <button type='button' onclick="location.href='./list_by_board_search_paging.do?boardno=${param.boardno}&word=${param.word }&nowPage=${param.nowPage }'" style="color: black;">목록</button>
		          </li>          
		        </c:when>
		      </c:choose>    
		    </UL>
		  </fieldset>
		
		</DIV>
		
		</DIV> <!-- content END -->
	</DIV> <!-- container END -->
	
  <div class="main_bottom">
    <c:import url="/menu/bottom.jsp"/>
  </div>
</div>
</body>

</html> 

  