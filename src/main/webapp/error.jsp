<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Tea</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com  /bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
</head>
<body>
<div class="main_wrapper" align="center">
  <c:import url="/menu/top.jsp"/>
  <c:import url="/menu/top_second.jsp"/>
    <div class="main_container" style="width: 80%;">
    <div class="title_l" style="font-size: 30px;  ">
      크롤링 결과가 없습니다. 다른 검색어를 검색해주세요.
      </div>
    </div>
  
    
</div>

<c:import url="/menu/bottom.jsp"/>



</body>
</html>