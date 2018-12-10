<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
<script type="text/javascript">
  $(function() {
    $('#panel_create').show(); // 등록
    $('#panel_update').hide(); // 수정
    
    list();  // 모든 카테고리 목록
    
  });
  
  // 모든 카테고리 목록
  function list() {
    $.ajax({
      url: "./list_by_categrp_json.do", // 요청을 보낼주소
      type: "get",  // or get
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: "categrpno=" + ${param.categrpno}, 
      // Ajax 통신 성공, JSP 정상 처리
      success: function(rdata) { // callback 함수
        var panel = '';
 
        for(index=0; index < rdata.length; index++) {
          panel += "<TR>";
          // panel += "<TD style='text-align: center ;'>"+rdata[index].boardno+"</TD>";
          panel += "<TD style='text-align: center ;'>"+(index+1)+"</TD>";
          panel += "<TD>"+rdata[index].categrp_name+"</TD>";
          panel += "<TD>"+rdata[index].board_name+"</TD>";
          panel += "<TD>"+rdata[index].memberno+"</TD>";
          panel += "<TD>"+rdata[index].rdate.substring(0, 10)+"</TD>";
          panel += "<TD style='text-align: center;'>"; 
          panel += "  <A href=\"javascript:update("+rdata[index].boardno+")\"><IMG src='./images/update.png' title='수정'></A>";  
          panel += "  <A href=\"javascript:deleteOne("+rdata[index].boardno+")\"><IMG src='./images/delete.png' title='삭제'></A>";
          panel += "</TD>";
          panel += "</TR>";
        }
        // alert(panel);
        // return;
        $('#tbody_panel').empty();
        $('#tbody_panel').append(panel);
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var panel = '';
        panel += "<DIV id='panel' class='popup1' style='heigth: 450px;'>";
        panel += '  ERROR<br><br>';
        panel += '  <strong>request.status</strong><br>'+request.status + '<hr>';
        panel += '  <strong>error</strong><br>'+error + '<hr>';
        panel += "  <br><button type='button' onclick=\"$('#main_panel').hide();\">닫기</button>";
        panel += "</DIV>";
        
        $('#main_panel').html(panel);
        $('#main_panel').show();
      }
    });
  }

  // 등록 처리
  function create() {
    $.ajax({
      url: "./create_json.do", // 요청을 보낼주소
      type: "post",  // or get
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: $('#frm_create').serialize(), 
      // Ajax 통신 성공, JSP 정상 처리
      success: function(rdata) { // callback 함수
        var panel = '';
        panel += "<DIV id='panel' class='popup1' style='heigth: 250px;'>";
        panel += '  알림<br>';
        for(index=0; index < rdata.msgs.length; index++) {
          panel += rdata.msgs[index]+'<br>';
        }
        panel += "  <button type='button' onclick=\"$('#main_panel').hide();\" class='popup_button'>닫기</button>";
        panel += "</DIV>";
        
        list();  // 전체 카테고리 목록
        
        $('#main_panel').html(panel);
        $('#main_panel').show();
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var panel = '';
        panel += "<DIV id='panel' class='popup1' style='heigth: 450px;'>";
        panel += '  ERROR<br><br>';
        panel += '  <strong>request.status</strong><br>'+request.status + '<hr>';
        panel += '  <strong>error</strong><br>'+error + '<hr>';
        panel += "  <br><button type='button' onclick=\"$('#main_panel').hide();\">닫기</button>";
        panel += "</DIV>";
        
        $('#main_panel').html(panel);
        $('#main_panel').show();
 
      }
    });
  }
  
  // 수정폼
  function update(boardno) {
    $('#panel_create').hide();
    $('#panel_update').show();
    
    $.ajax({
      url: "./update.do", // 요청을 보낼주소
      type: "get",  // or get
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: 'boardno=' +boardno,  // $('#frm').serialize(), 
      // Ajax 통신 성공, JSP 정상 처리
      success: function(rdata) { // callback 함수
        var frm_update = $('#frm_update');
        $('#categrpno', frm_update).val(rdata.categrpno);
        $('#boardno', frm_update).val(rdata.boardno);        
        $('#name', frm_update).val(rdata.name);
        $('#memberno', frm_update).val(rdata.memberno);        
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var panel = '';
        panel += "<DIV id='panel' class='popup1' style='heigth: 350px;'>";
        panel += '  ERROR<br><br>';
        panel += '  <strong>request.status</strong><br>'+request.status + '<hr>';
        panel += '  <strong>error</strong><br>'+error + '<hr>';
        panel += "  <br><button type='button' onclick=\"$('#main_panel').hide();\">닫기</button>";
        panel += "</DIV>";
        
        $('#main_panel').html(panel);
        $('#main_panel').show();

      }
    });
  } 

  // 수정 처리
  function update_submit() {
    $.ajax({
      url: "./update_json.do", // 요청을 보낼주소
      type: "post",  // or get
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: $('#frm_update').serialize(), 
      // Ajax 통신 성공, JSP 정상 처리
      success: function(rdata) { // callback 함수
        var panel = '';
        panel += "<DIV id='panel' class='popup1' style='heigth: 250px;'>";
        panel += '  알림<br>';
        for(index=0; index < rdata.msgs.length; index++) {
          panel += rdata.msgs[index]+'<br>';
        }
        panel += "  <button type='button' onclick=\"$('#main_panel').hide();\" class='popup_button'>닫기</button>";
        panel += "</DIV>";
        
        list();  // 전체 카테고리 목록
        
        $('#main_panel').html(panel);
        $('#main_panel').show();
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var panel = '';
        panel += "<DIV id='panel' class='popup1' style='heigth: 450px;'>";
        panel += '  ERROR<br><br>';
        panel += '  <strong>request.status</strong><br>'+request.status + '<hr>';
        panel += '  <strong>error</strong><br>'+error + '<hr>';
        panel += "  <br><button type='button' onclick=\"$('#main_panel').hide();\">닫기</button>";
        panel += "</DIV>";
        
        $('#main_panel').html(panel);
        $('#main_panel').show();
 
      }
    });
  }

  
  function create_update_cancel() {
    $('#panel_update').hide();
    $('#panel_create').show();

  }
  
  
</script>
 
</head> 
 
<body>
<DIV class='container' style='width: 100%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 100%;'>
  
  <DIV id='main_panel'></DIV>
  
  <DIV class='title_line'>${categrpVO.name } 카테고리</DIV>
 
  <FORM name='frm_delete' id='frm_delete' method='post' action='./delete.do'>
    <input type='hidden' name='categrpno' id='categrpno' value=''>
    <input type='hidden' name='boardno' id='boardno' value=''>
  </FORM>
  
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F5F5F5; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
      <!-- 개발시 임시 값 사용 -->
      <!-- 
      <input type='hidden' name='categrpno' id='categrpno' value='1'>
       -->
       
      <label for='categrp'>카테고리 그룹 번호</label>
      <input type='number' name='categrpno' id='categrpno' value='${param.categrpno }' required="required" style='width: 5%;'>
      
      <label for='name'>카테고리 이름</label>
      <input type='text' name='name' id='name' size='10' value='' required="required" style='width: 10%;'>
 
      <label for='memberno'>접근 계정</label>
      <input type='text' name='memberno' id='memberno' value='' required="required" style='width: 10%;'>
 
      <button type="button" id='submit' onclick="create()">등록</button>
      <button type="button" onclick="create_update_cancel()">취소</button>
    </FORM>
  </DIV>
  
  <!--  수정폼은 항상 PK 전달한다. -->
  <DIV id='panel_update' style='padding: 10px 0px 10px 0px; background-color: #DDDDDD; width: 100%; text-align: center;'>  
    <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
      <input type='hidden' name='boardno' id='boardno' value=''> 
 
      <label for='title'>카테고리 그룹 번호</label>
      <input type='number' name='categrpno' id='categrpno' size='7' value='' required="required" style='width: 3%;'>
        
      <label for='name'>카테고리 이름</label>
      <input type='text' name='name' id='name' size='15' value='' required="required" style='width: 20%;'>
 
      <label for='memberno'>접근 계정</label>
      <input type='text' name='memberno' id='memberno' value='' required="required" style='width: 10%;'>
 
      <button type="button" id='submit' onclick="update_submit()">저장</button>
      <button type="button" onclick="create_update_cancel()">취소</button>
    </FORM>
  </DIV>
  
<TABLE class='table table-striped'>
  <colgroup>
<%--     <col style='width: 10%;'/>
    <col style='width: 10%;'/> --%>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 25%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 15%;'/>
 
  </colgroup>
  <thead>  
  <TR>
<!--     <TH style='text-align: center ;'>categrpno</TH>
    <TH style='text-align: center ;'>seqno</TH> -->
    <TH style='text-align: center ;'>번호</TH>
    <TH style='text-align: center ;'>그룹</TH>
    <TH style='text-align: center ;'>카테고리</TH>
    <TH style='text-align: center ;'>접근계정</TH>
    <TH style='text-align: center ;'>등록일자
    <TH style='text-align: center ;'>기타</TH>
    
  </TR>
  </thead>
 
  <tbody id='tbody_panel' data-nowPage='0' data-endPage='0'>
  </tbody>
  
</TABLE>
 
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 
 