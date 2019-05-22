<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>블로그 삭제</title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">

</script>

</head> 

<body>
<div class="main_wrapper" align=center>
  <c:import url="/menu/top.jsp"/>
  <c:import url="/menu/top_second.jsp"/>
  
	<DIV class='main_container' style="width: 80%;">
		<DIV class='contents' align="center">
		   
		  <div class="member_aside"> 
			  <ASIDE style='float: left; padding: 15px 0px 15px 0px;'>
			    <A href='../board/list.do' style="font-weight: bold; color: white;">게시판 목록</A>
			    >  
			    <A href='./list_by_boardno.do?boardno=${boardVO.boardno }' style="font-weight: bold; color: white;">${boardVO.name }</A>
			  </ASIDE>
			  <ASIDE style='float: right; padding: 15px 0px 15px 0px;'>
			    <A href="javascript:location.reload();" style="font-weight: bold; color: white;">새로고침</A>
			    <span class='menu_divide' >│</span> 
			    <A href='./create.do?boardno=${boardVO.boardno }' style="font-weight: bold; color: white;">등록</A>
			    <span class='menu_divide' >│</span> 
			    <A href='./list_by_boardno.do?boardno=${boardVO.boardno }&word_find=${word_find}' style="font-weight: bold; color: white;">목록</A>
			
			  </ASIDE> 
		  </div>
		  
		
		  <FORM name='frm' method='POST' action='./delete.do'>
		      <input type='hidden' name='contentsno' value='${contentsVO.contentsno}'>
		      <input type="hidden" name="boardno" value="${boardVO.boardno }">
		      <input type="hidden" name="nowPage" value="${param.nowPage }">
		            
		      <div class="form-group" style="clear: both;">   
		        <div class="col-md-12" style='text-align: center; margin: 30px; color: white;'>
		          삭제 되는글: ${contentsVO.name }<br><br>
		          삭제하시겠습니까? 삭제하시면 복구 할 수 없습니다.<br><br>
		          <button class='btn btn-danger' type="submit">삭제 진행</button>
		          <button class='btn btn-default' type="button" onclick = "history.back()">취소</button>
		        </div>
		      </div>   
		  </FORM>
		
		</DIV> <!-- content END -->
	</DIV> <!-- container END -->
	
	<div class="main_bottom">
    <c:import url="/menu/bottom.jsp"/>
  </div>
  
</div>
</body>

</html> 

  