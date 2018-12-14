<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
<script type="text/javascript" src="../js/jquery.cookie.js"></script>
 
<script type="text/javascript">
  
</script>
 
 
</head> 
 
 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
 
  <DIV id='main_panel'></DIV>
 
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
    
  
  <ASIDE style='float: left;'>
      <A href='./member/list.do'>회원 목록</A>  
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>목록</A>
  </ASIDE> 
 
  <div class='menu_line'></div>
  
 
  <DIV class='title_line'>회원 정보 조회 및 수정</DIV>
 
  <FORM name='frm' id='frm' method='POST' action='./update.do' 
              onsubmit="return send();" class="form-horizontal">
    <input type='hidden' name='memberno' id='memberno' value='${memberVO.memberno }'>          
 
    <div class="form-group">
      <label for="id" class="col-md-2 control-label">아이디</label>    
      <div class="col-md-10">
        ${memberVO.id }        
      </div>
    </div>   
                
    <div class="form-group">
      <label for="name" class="col-md-2 control-label">성명</label>    
      <div class="col-md-10">
        <input type='text' class="form-control input-md" name='name' id='name' 
                   value='${memberVO.name }' required="required" style='width: 30%;' placeholder="성명">
      </div>
    </div>   
 
    <div class="form-group">
      <label for="phone" class="col-md-2 control-label">전화번호</label>    
      <div class="col-md-10">
        <input type='text' class="form-control input-md" name='phone' id='phone' 
                   value='${memberVO.phone }' required="required" style='width: 30%;' placeholder="전화번호"> 예) 01000000000
      </div>
    </div>   
 
    <div class="form-group">
      <label for="email" class="col-md-2 control-label">이메일</label>    
      <div class="col-md-10">
        <input type='text' class="form-control input-md" name='email' id='email' 
                   value='${memberVO.email }' required="required" style='width: 30%;' placeholder="이메일">
      </div>
    </div>  

    <div class="form-group">
      <div class="col-md-offset-2 col-md-10">
        <button type="submit" class="btn btn-primary btn-md">저장</button>
        <button type="button" onclick="history.go(-1);" class="btn btn-primary btn-md">취소</button>
 
      </div>
    </div>   
  </FORM>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 