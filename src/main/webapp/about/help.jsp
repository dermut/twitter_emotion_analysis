<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>도움말</title>
 
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
  <br>
    <div class="contents" align="center">
      <img alt="explain" src="./explain.PNG" class="Image">
    </div>
    
        <div class="main_bottom">
 <c:import url="/menu/bottom.jsp"/>
  </div>
  </div>
</div>
</body>
</html>