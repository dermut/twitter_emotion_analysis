<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Tea</title>
 
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
</head>
<body>

<div class="main_wrapper">
  <c:import url="/menu/top.jsp"/>
	
  <c:import url="/menu/top_second.jsp"/>
	
	<div class="main_container">
	  <div class="contents" align="center">
	    <div class="main_logo">
	      <img alt="TEA Logo" src="./main_logo.jpg" class="Image">
	    </div>
	    
	    <FORM class="main_search_bar_frm" name='frm' id='frm' method='POST' action='./word/create.do' >
        <input class="main_search_bar_txt" type="text" id="word" name="word" placeholder="키워드..." autocomplete="off">
	      <button type="submit" class="main_search_button">검색
	        <i class="__Image__Image-42" style="background-image: ${pageContext.request.contextPath}/image/button.png"></i>
        </button>
	    </FORM>
		  
	  </div> <!-- contents END -->
	</div> <!-- container END -->
	
	<div class="main_bottom">
	  <c:import url="/menu/bottom.jsp"/>
	</div>
</div>
</body>
</html>