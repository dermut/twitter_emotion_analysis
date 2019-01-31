<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>아이디/비밀번호 찾기</title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript" src="../js/jquery.cookie.js"></script>

</head> 

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 100%;'>

<DIV class='title_line' style='width: 20%;'>아이디 / 비밀번호 찾기</DIV>

<DIV style='width: 100%; margin: 0px auto;'>
  
  <FORM name='frm' method='GET' action='./find_id.do'>
     <!-- 아이디 찾기 div -->
    <div class="form-group">
      <label for="id" class="col-md-2 control-label">이름</label>    
      <div class="col-md-10">
        <input type='text' class="form-control input-md" name='name' id='name' value='' required="required" style='width: 30%;' placeholder="이름" autofocus="autofocus">        
      </div><br>
      <label for="id" class="col-md-2 control-label">이메일</label>    
      <div class="col-md-10">
        <input type='text' class="form-control input-md" name='email' id='email' value='' required="required" style='width: 30%;' placeholder="이메일" autofocus="autofocus">        
      </div><br>
      
    </div>   
    
     <!-- 아이디 찾기 버튼 -->
     <div class="form-group">
      <div class="col-md-offset-2 col-md-10">
        <button type="submit" class="btn btn-primary btn-md">아이디 찾기</button>
     </div>
    </div>  
    </FORM>

  <FORM name='frm' method='GET' action='./find_passwd.do'>
     <!-- 비밀번호 찾기 div -->
    <div class="form-group">
      <label for="id" class="col-md-2 control-label">아이디</label>    
      <div class="col-md-10">
        <input type='text' class="form-control input-md" name='id' id='id' value='' required="required" style='width: 30%;' placeholder="아이디">
      </div>
      <label for="name" class="col-md-2 control-label">이름</label>
      <div class="col-md-10">
        <input type='text' class="form-control input-md" name='name' id='name' value='' required="required" style='width: 30%;' placeholder="이름">
      </div>
      <label for="email" class="col-md-2 control-label">이메일</label>
      <div class="col-md-10">
        <input type='text' class="form-control input-md" name='email' id='email' value='' required="required" style='width: 30%;' placeholder="이메일">
      </div>
    </div>   
    
     <!-- 비밀번호 찾기 버튼 -->
      <div class="form-group">
        <div class="col-md-offset-2 col-md-10">
          <button type="submit" class="btn btn-primary btn-md">비밀번호 찾기</button>
        </div>
      </div>  
  </FORM>

      <!-- 버튼 -->
    <div class="form-group">
      <div class="col-md-offset-2 col-md-10">
        <button type="submit" class="btn btn-primary btn-md">로그인</button>
        <button type="button" onclick="history.back()" class="btn btn-primary btn-md">취소</button>
        <button type="button" onclick="location.href='./create.do'" class="btn btn-primary btn-md">회원가입</button>
      </div>
    </div>   
    
  
</DIV>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->

</body>

</html> 
 
 
 