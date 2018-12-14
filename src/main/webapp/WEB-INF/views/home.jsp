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
<div class="container">

  <div class="contents">
  
  <c:import url="/menu/top.jsp"/>
  
    <div class="form-group">
      <label for="search">검색: </label>
      <input type="text" class="form-control" id="search" style="top: 50%; left: 50%; margin: auto auto;">
    </div>
    
    <c:import url="/menu/bottom.jsp"/>
    
  </div> <!-- contents END -->
</div> <!-- container END -->
</body>
</html>