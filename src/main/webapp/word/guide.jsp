<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
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
		      <img alt="TEA Guide Logo" src="./guide-logo-fixed.jpg" class="Image">
		    </div>
	    
	      <FORM class="main_search_bar_frm" name='frm' id='frm' method='POST' action='./create.do' >
	         <input class="main_search_bar_txt" type="text" id="word" name="word" placeholder="키워드..." autocomplete="off">
	        <button type="submit" class="main_search_button">검색
	          <i class="__Image__Image-42" style="background-image: ${pageContext.request.contextPath}/image/button.png"></i>
	        </button>
	      </FORM>
		    
		    <div class="guide_main" align="center">
		      TEA는 트위터에서 크롤링한 트윗을 기반으로 <br>
		      통계를 내 여러분에게 통찰을 주고자 하는 사이트입니다. <br>
		      알고 싶은 내용을 검색해주세요.<br>
		    </div>
	    
		  </div> <!-- contents END -->
		</div> <!-- container END -->
		
		<div class="bottom">
		  <c:import url="/menu/bottom.jsp"/>
		</div>
	</div>

</body>
</html>