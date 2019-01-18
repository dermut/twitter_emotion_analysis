<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
 
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
<script type="text/javascript">
  $(function(){
 
  });
</script>
 
</head> 
 
<body>
<div class="main_wrapper main_wrapper--index">
  <div class="top">
    <c:import url="/menu/top.jsp"/>
  </div>
  
  <div class="top_second">
    <c:import url="/menu/top_second.jsp"/>
  </div>
  
  <div class="main_container">
    <div class="contents" align="center">
		 
		<DIV class='name_line' style='width: 40%;'>카테고리 등록</DIV>
		 
		<FORM name='frm' method='POST' action='./create.do'>
		  <!-- 개발시 임시 값 사용 -->
		  <input type='hidden' name='categrpno' id='categrpno' value='1'>
		 
		  <fieldset class='fieldset_basic'>
		    <ul>
		      <li class='li_none'>
		        <label>카테고리 그룹 '${categrpVO.name }'에 새로운 게시판을 등록합니다.</label>
		      </li>
		    
		      <li class='li_none'>
		        <label for='name'>게시판 이름</label>
		        <input type='text' name='name' id='name' value='' required="required" autofocus="autofocus">
		      </li>
		      <li class='li_none'>
		        <label for='memberno'>접근 계정</label>
		        <input type='text' name='memberno' id='memberno' value='${memberVO.memberno }' required="required">
		      </li>
		 
		      <li class='li_right'>
		        <button type="submit">등록</button>
		        <button type="button" onclick="location.href='./list.do'">목록</button>
		      </li>         
		    </ul>
		  </fieldset>
		</FORM>
		 
		 
		</DIV> <!-- content END -->
		<jsp:include page="/menu/bottom.jsp" flush='false' />
	</DIV> <!-- container END -->
</div>
</body>
 
</html> 

