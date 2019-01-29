<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

<script type="text/JavaScript">
  window.onload=function(){
    CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
  };
</script>

</head> 

<body>
<div class="main_wrapper" align=center>

  <c:import url="/menu/top.jsp"/>
  
  <c:import url="/menu/top_second.jsp"/>
  
  <DIV class='main_container' style='width: 80%;'>
    <DIV class='contents'>   

    <div class="contents_aside">
		  <ASIDE style='float: left; color: white; padding: 20px 0px 10px 10px;'>
		      <A href='../board/list.do' style="color: white;">게시판 목록</A>  
		      >
		      <A href='./list.do?boardno=${boardVO.boardno }' style="color: white;">${boardVO.name }</A>
		  </ASIDE>
		  <ASIDE style='float: right; color: white; padding: 20px 0px 10px 10px;'>
		    <A href="javascript:location.reload();" style="color: white;">새로고침</A>
		    <span class='menu_divide'  style="color: white;">│</span> 
		    <A href='./create.do' style="color: white;">등록</A>
		  </ASIDE> 
		</div>

  <div class='menu_line'></div>
  <DIV class='content' style='width: 100%;'>
    <FORM name='frm' method='POST' action='./create.do'
               enctype="multipart/form-data" class="form-horizontal">
               
      <input type='hidden' name='boardno' id='boardno' value='${param.boardno }'>
      <input type='hidden' name='memberno' id='memberno' value='${user_memberno }'>
      
      <div class="form-group">   
        <label for="name" class="col-md-1 control-label">글 제목</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='name' id='name' value='바다건너' required="required" style='width: 80%;'>
        </div>
      </div>   
      <div class="form-group">   
        <label for="content" class="col-md-1 control-label">내용</label>
        <div class="col-md-11">
          <textarea class="form-control input-lg" name='content' id='content'  rows='10'>크리스마스에 갔던곳</textarea>
        </div>
      </div>
      <div class="form-group">   
        <label for="photoMF" class="col-md-1 control-label">업로드 파일</label>
        <div class="col-md-11">
          <input type="file" class="form-control input-lg" name='photoMF' id='photoMF' size='40' multiple="multiple">
          <br>
          Preview(미리보기) 이미지는 자동 생성됩니다.
        </div>
      </div>
      
      <DIV style='text-align: right;'>
        <button type="submit">등록</button>
        <button type="button" onclick="location.href='./list_by_board_search_paging.do?boardno=${boardVO.boardno}'">취소[목록]</button>
      </DIV>
    </FORM>
  </DIV>


  </DIV> <!-- content END -->
  
  <div class="main_bottom">
    <c:import url="/menu/bottom.jsp"/>
  </div>
  
  </DIV> <!-- container END -->

</div>
</body>

</html> 

