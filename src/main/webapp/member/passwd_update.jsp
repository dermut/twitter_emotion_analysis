<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
<script type="text/javascript" src="../js/jquery.cookie.js"></script>
 
<script type="text/javascript">
  
  $(function() {
 
  });
 
  function send() {
    if ($('#new_passwd').val() != $('#new_passwd2').val()) {
      var msg = "입력된 패스워드가 일치하지 않습니다.<br>";
      msg += "패스워드를 다시 입력해주세요.<br>";
 
      $('#modal_title').html('패스워드 일치여부 확인');
      $('#modal_content').attr('class', 'alert alert-danger');
      $('#modal_content').html(msg);
      $('#modal_panel').modal(); // 다이얼로그 출력   
      
      return false; // submit 중지
    }
    
    return true; 
  }
</script>
 
</head> 
 
 
<body>
<div class="main_wrapper">
  <c:import url="/menu/top.jsp"/>

  <c:import url="/menu/top_second.jsp"/>
  
  <div class="main_container" align=center>
    <div class="contents" style="width: 80%;">
		 
		  <!-- Modal -->
		  <div class="modal fade" id="modal_panel" role="dialog">
		    <div class="modal-dialog">
		    
		      <!-- Modal content-->
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">×</button>
		          <h4 class="modal-title" id='modal_title'></h4>
		        </div>
		        <div class="modal-body">
		          <p id='modal_content'></p>
		        </div>
		        <div class="modal-footer">
		          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		        </div>
		      </div>
		      
		    </div>
		  </div> <!-- Modal END -->
		 
		  <div class="member_aside">
			  <ASIDE style='float: left; padding:25px 0px 15px 0px;'>
			      <A href='./member/list.do' style="font-weight: bold; color: white;">회원 목록</A>  
			  </ASIDE>
			  <ASIDE style='float: right; padding: 25px 0px 15px 0px;'>
			    <A href="javascript:location.reload();" style="font-weight: bold; color: white;">새로고침</A>
			    <span class='menu_divide' >│</span> 
			    <A href='./create.do' style="font-weight: bold; color: white;">회원 가입</A>
			    <span class='menu_divide' >│</span> 
			    <A href='./list.do' style="font-weight: bold; color: white;">목록</A>
			  </ASIDE> 
		  </div>
		  
	
		  
		  <div class='menu_line'></div>
		    
		  <DIV class='title_l'>패스워드 변경</DIV>
		 
		 
		  <FORM name='frm' method='POST' action='./passwd_update.do' 
		             onsubmit="return send();" style="padding-top: 30px; width: 50%;">
		 
		    <div class="form-group">
          <label for="passwd" class="control-label" style="float: left; color: white; padding: 0px 3px 3px 3px;">현재 패스워드</label>    
          <input type='password' class="form-control" name='passwd' id='passwd' value='' required="required" placeholder="현재 패스워드">
		    </div>   
		                    
		    <div class="form-group">
		      
		      <label for="passwd" class="control-label" style="float: left; color: white; padding: 0px 3px 3px 3px;">새로운 패스워드</label>    
	        <input type='password' class="form-control" name='new_passwd' id='new_passwd' value='' required="required" placeholder="새로운 패스워드">
		    </div>   
		 
		    <div class="form-group">
		      <label for="passwd2" class="control-label" style="float: left; color: white; padding: 0px 3px 3px 3px;">새로운 패스워드 확인</label>    
	        <input type='password' class="form-control" name='new_passwd2' id='new_passwd2' value='' required="required" placeholder="새로운 패스워드 확인">
		    </div>   
		    
		    <div class="form-group">
	        <button type="submit" class="btn btn-primary btn-md">변경</button>
	        <button type="button" onclick="location.href='./list.do'" class="btn btn-danger btn-md">취소</button>
		    </div>   
		 </FORM>
		 
		</DIV> <!-- content END -->
	<jsp:include page="/menu/bottom.jsp" flush='false' />
	</DIV> <!-- container END -->
</div>
</body>
 
</html> 