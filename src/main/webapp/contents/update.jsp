<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>블로그 수정</title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ckfinder/ckfinder.js"></script>

<script type="text/JavaScript">
  window.onload=function(){

  };
</script>

</head> 

<body>
<div class="main_wrapper" align=center>
  <c:import url="/menu/top.jsp"/>
  
  <c:import url="/menu/top_second.jsp"/>
  
  <div class="main_container" style='width: 80%;'>
    <div class="contents" align="center">

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
		  <FORM name='frm' method='POST' action='./update.do'
		             enctype="multipart/form-data" class="form-horizontal">
		      <input type='hidden' name='boardno' id='boardno' value='${boardVO.boardno }'>
		      <input type='hidden' name='contentsno' id='contentsno' value='${contentsVO.contentsno }'>
		      
		      <div class="form-group">   
		        <label for="name" class="col-md-1 control-label">제목</label>
		        <div class="col-md-11">
		          <input type='text' class="form-control input-md" name='name' id='name' value='${contentsVO.name}' required="required">
		        </div>
		      </div>   
		      <div class="form-group">   
		        <label for="content" class="col-md-1 control-label">내용</label>
		        <div class="col-md-11">
		          <textarea class="form-control input-md" name='content' id='content'>${contentsVO.content}</textarea>
		        </div>
		      </div>
		      
		      <script>
		        ClassicEditor 
		        .create(document.querySelector('#content'),{
		          toolbar: {
		            items: [
		                'heading',
		                '|',
		                'alignment',
		                'bold',
		                'italic',
		                'link',
		                'bulletedList',
		                'numberedList',
		                'blockQuote',
		                'undo',
		                'redo'
		            ]
		          },
		          image: {
		            toolbar: [
		                'imageStyle:full',
		                'imageStyle:side',
		                '|',
		                'imageTextAlternative'
		            ]
		          },
		          language: 'kor'
		        })
		        .then(editor => {
		          console.log(editor);
		        })
		        .catch(error => {
		          console.error(error);
		        });
		      </script>
		      
		      <div id='photoPanel' class="form-group">
		        <label class="col-md-2 control-label"></label>
		        <div class="col-md-10">
		          <c:if test="${file_list.size() > 0 }">
		              <DIV>
		                <c:forEach var ="fileVO"  items="${file_list }">
		                  <A href="javascript: panel_img('${fileVO.file }')"><IMG src='./storage/${fileVO.thumb }' style='margin-top: 2px;'></A>
		                </c:forEach>
		              </DIV>
		            </c:if>
		        </div>
		      </div>
		      <div class="form-group">   
		        <label for="photoMF" class="col-md-1 control-label">파일</label>
		        <div class="col-md-11" style="color: white;">
		          <input type="file" class="form-control input-md" name='photoMF' id='photoMF' size='40' multiple="multiple">
		          <br>
		          Preview(미리보기) 이미지는 자동 생성됩니다.
		        </div>
		      </div>   
		
		      <DIV style='text-align: right;'>
		        <button type="submit">변경된 내용 저장</button>
		        <button type="button" onclick="history.back();">취소[목록]</button>
		      </DIV>
		  </FORM>
		
		
		</DIV> <!-- contents END -->
	</DIV> <!-- container END -->
	
	<div class="main_bottom">
    <c:import url="/menu/bottom.jsp"/>
  </div>
  
</div>
</body>

</html> 
 
 
