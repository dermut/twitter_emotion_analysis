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
  $(function() {
    $.cookie('checkID', 'FALSE'); // Cookie 생성
    $('#popup').hide();
  });
  
  function checkId(){
    var frm = $('#frm');
    var params = 'id='+$('#id', frm).val(); // #: id
    // alert('params: ' + params);
    
    $.ajax({
      url: "./checkId.do",
      type: "GET",
      cache: false,
      dataType: "json", // or html
      data: params,
      success: function(data){
        var msg = "";
 
        if (data.cnt > 0) {
          $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap
          msg = "『Danger!』 이미 사용중인 ID 입니다.";
        } else {
          $('#modal_content').attr('class', 'alert alert-success'); // Bootstrap
          msg = "『Success!』 사용 가능한 ID 입니다.";
          
          $.cookie('checkID', 'TRUE'); // Cookie 값 변경
        }
 
        $('#modal_title').html('ID 중복 확인');
        $('#modal_content').html(msg);
        $('#modal_panel').modal(); // 다이얼로그 출력   
      },
      // 통신 에러, 요청 실패, 200 아닌 경우, dataType이 다른경우
      error: function (request, status, error){  
        var msg = "에러가 발생했습니다. <br><br>";
        msg += "다시 시도해주세요.<br><br>";
        msg += "request.status: " + request.status + "<br>";
        msg += "request.responseText: " + request.responseText + "<br>";
        msg += "status: " + status + "<br>";
        msg += "error: " + error;
 
        // var panel = "";
        // panel += "<DIV id='panel' class='popup1' style='height: 350px;'>";
        // panel += msg;
        // panel += "<br>[<A href=\"javascript: $('#main_panel').hide()\">CLOSE</A>]";
        // panel += "</DIV>";
        
        // $('#main_panel').html(panel);      
        // $('#main_panel').show();
            // id_span.html(msg);
        $('#modal_title').html('ID 중복 확인');
        $('#modal_content').attr('class', 'alert alert-danger');
        $('#modal_content').html(msg);
        $('#modal_panel').modal(); // 다이얼로그 출력   
      }
    });
 
  }
  
  function send() {
    var check = $.cookie('checkID'); // 쿠키값
    
    if (check != 'TRUE') {
      var msg = "ID 중복확인이 되지 않았습니다.<br>";
      msg += "ID [중복확인] 버튼을 클릭하세요.<br>";
 
      $('#modal_title').html('ID 체크 확인');
      $('#modal_content').attr('class', 'alert alert-danger');
      $('#modal_content').html(msg);
      $('#modal_panel').modal(); // 다이얼로그 출력   
      
      return false; // submit 중지
    }
    
    if ($('#passwd').val() != $('#passwd2').val()) {
      var msg = "입력된 패스워드가 일치하지 않습니다.<br>";
      msg += "패스워드를 다시 입력해주세요.<br>";
 
      $('#modal_title').html('패스워드 일치여부 확인');
      $('#modal_content').attr('class', 'alert alert-danger');
      $('#modal_content').html(msg);
      $('#modal_panel').modal(); // 다이얼로그 출력   
      
      return false; // submit 중지
    }
    
    return true; // submit 진행
  }
  
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
    <A href='./list.do'>목록</A>
  </ASIDE> 
 
  <div class='menu_line'></div>
  
 
  <DIV class='title_line'>회원가입</DIV>
 
  <FORM name='frm' id='frm' method='POST' action='./create.do' 
              onsubmit="return send();" class="form-horizontal">
 
    <div class="form-group">
      <label for="id" class="col-md-2 control-label">아이디</label>    
      <div class="col-md-10">
        <input type='text' class="form-control input-md" name='id' id='id' value='user' required="required" style='width: 30%;' placeholder="아이디" autofocus="autofocus">
        <button type='button' onclick="checkId()" class="btn btn-info btn-md">중복확인</button>
        <SPAN id='id_span'></SPAN> <!-- ID 중복 관련 메시지 -->        
      </div>
    </div>   
                
    <div class="form-group">
      <label for="passwd" class="col-md-2 control-label">패스워드</label>    
      <div class="col-md-10">
        <input type='password' class="form-control input-md" name='passwd' id='passwd' value='1234' required="required" style='width: 30%;' placeholder="패스워드">
      </div>
    </div>   
 
    <div class="form-group">
      <label for="passwd2" class="col-md-2 control-label">패스워드 확인</label>    
      <div class="col-md-10">
        <input type='password' class="form-control input-md" name='passwd2' id='passwd2' value='1234' required="required" style='width: 30%;' placeholder="패스워드">
      </div>
    </div>   
    
    <div class="form-group">
      <label for="name" class="col-md-2 control-label">성명</label>    
      <div class="col-md-10">
        <input type='text' class="form-control input-md" name='name' id='name' 
                   required="required" style='width: 30%;' placeholder="성명">
      </div>
    </div>   
    
    <div class="form-group">
      <label for="email" class="col-md-2 control-label">이메일</label>    
      <div class="col-md-10">
        <input type='text' class="form-control input-md" name='email' id='email' 
                   required="required" style='width: 30%;' placeholder="이메일">
      </div>
    </div>   
 
    <div class="form-group">
      <label for="phone" class="col-md-2 control-label">전화번호</label>    
      <div class="col-md-10">
        <input type='text' class="form-control input-md" name='phone' id='phone' 
                   value='010-0000-0000' required="required" style='width: 30%;' placeholder="전화번호"> 예) 01000000000
      </div>
    </div>   
 
    <div class="form-group">
      <label for="birth" class="col-md-2 control-label">생년월일</label>    
      <div class="col-md-10">
        <input type='date' class="form-control input-md" name='birth' id='birth' 
                   required="required" style='width: 30%;' placeholder="생년월일">
      </div>
    </div>  
 
    <div class="form-group">
      <label for="sex" class="col-md-2 control-label">성별</label>    
      <div class="col-md-10">
        <input type='radio' name='sex' 
                   value='남' required="required" style='width: 3%;' placeholder="남자" checked>남자
                   <input type='radio'name='sex'  
                   value='여' required="required" style='width: 3%;' placeholder="여자">여자
                   <input type='radio' name='sex' 
                   value='중' required="required" style='width: 3%;' placeholder="해당없음">해당없음
      </div>
    </div>   
 
    <div class="form-group">
      <div class="col-md-12">
 
      </div>
    </div>
    
    <div class="form-group">
      <div class="col-md-offset-2 col-md-10">
        <button type="submit" class="btn btn-primary btn-md">가입</button>
        <button type="button" onclick="location.href='../index.jsp'" class="btn btn-primary btn-md">취소</button>
 
      </div>
    </div>   
  </FORM>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 