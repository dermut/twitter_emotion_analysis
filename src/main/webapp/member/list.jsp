<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>회원 목록</title> 
 
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 
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
<div class="main_wrapper">
  <c:import url="/menu/top.jsp"/>

  <c:import url="/menu/top_second.jsp"/>
  
  <div class="main_container" align=center>
    <div class="contents" style="width: 80%;">
        
      <div class="member_aside" >
        <ASIDE style='float: left; padding:15px 0px 15px 0px;'>
            <A href='./member/list.do' style="font-weight: bold; color: white;">회원 목록</A>  
        </ASIDE>
        <ASIDE style='float: right; padding: 15px 0px 15px 0px;'>
          <A href="javascript:location.reload();" style="font-weight: bold; color: white;">새로고침</A>
          <!-- <span class='menu_divide' >│</span> 
          <A href='./create.do' style="font-weight: bold; color: white;">회원 가입</A> -->
          <span class='menu_divide' >│</span> 
          <A href='./list.do' style="font-weight: bold; color: white;">목록</A>
        </ASIDE> 
      </div>
        
      <div class='menu_line'></div>
     
      <table class="table table-striped table-hover" style='background-color: #F9F9F9; width: 100%; text-align: center;'>
      <colgroup>
        <col style='width: 5%;'/>
        <col style='width: 10%;'/>
        <col style='width: 10%;'/>
        <col style='width: 5%;'/>
        <col style='width: 5%;'/>
        <col style='width: 15%;'/>
        <col style='width: 20%;'/>
        <col style='width: 15%;'/>
        <col style='width: 15%;'/>
      </colgroup>
      <TR >
        <TH class='th'>번호</TH>
        <TH class='th'>ID</TH>
        <TH class='th'>성명</TH>
        <TH class='th'>성별</TH>
        <TH class='th'>등급</TH>
        <TH class='th'>전화번호</TH>
        <TH class='th'>이메일</TH>
        <TH class='th'>등록일</TH>
        <TH class='th'>기타</TH>
      </TR>
     
      <c:forEach var="memberVO" items="${list }">
        <c:set var="memberno" value ="${memberVO.memberno }" /> 
      <TR>
        <TD class='td'>${memberno}</TD>
        <TD class='td'><A href="./read.do?memberno=${memberno}">${memberVO.id}</A></TD>
        <TD class='td'><A href="./read.do?memberno=${memberno}">${memberVO.name}</A></TD>
        <TD class='td'>${memberVO.sex}</TD>
        <TD class='td'>${memberVO.grade}</TD> <!-- 등급 -->
        <TD class='td'>${memberVO.phone}</TD>
        <TD class='td'>${memberVO.email}</TD>
        <TD class='td'>${memberVO.rdate.substring(0, 10)}</TD> <!-- 년월일 -->
        <TD class='td'>
          <A href="./passwd_update.do?memberno=${memberno}"><span class='glyphicon glyphicon-lock' title='패스워드 변경'></span></A>
          <A href="./read.do?memberno=${memberno}"><span class="glyphicon glyphicon-edit" title="수정"></span></A>
          <A href="./delete.do?memberno=${memberno}"><span class="glyphicon glyphicon-remove" title="삭제" ></span></A>
        </TD>
        
      </TR>
      </c:forEach>
      
      </TABLE>
     
      <DIV class='button-group'>
        <!-- <button class="btn btn-default" type='button' onclick="location.href='./create.do'">등록</button> -->
        <button class="btn btn-default" type='button' onclick="location.reload();">새로 고침</button>
      </DIV>
 
    </DIV> <!-- content END -->
    
    <div class="main_bottom">
      <c:import url="/menu/bottom.jsp"/>
    </div>
  </DIV> <!-- container END -->
</div>
</body>
 
</html>