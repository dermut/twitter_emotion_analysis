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
    $('#panel_delete').hide(); // 삭제
    
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
          panel += "<TD><A href='../contents/list_by_board_search_paging.do?boardno="+rdata[index].boardno+"'>"+rdata[index].board_name+"</A></TD>";
          panel += "<TD>"+rdata[index].id+"</TD>";
          panel += "<TD>"+rdata[index].rdate.substring(0, 10)+"</TD>";
          panel += "<TD style='text-align: center;'>"; 
          panel += "  <A href='../contents/create.do?boardno="+rdata[index].boardno+"'><IMG src='./images/create.png' name='등록'></A>";
          panel += "  <A href=\"javascript:update("+rdata[index].boardno+")\"><IMG src='./images/update.png' name='수정'></A>";  
          panel += "  <A href=\"javascript:deleteForm("+rdata[index].boardno+")\"><IMG src='./images/delete.png' name='삭제'></A>"; 
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
    $('#panel_delete').hide();
    
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
  
  function create_update_cancel() {
    $('#panel_update').hide();
    $('#panel_create').show();
    $('#panel_delete').hide();
  }
  
  //삭제 폼
  function deleteOne(boardno) {
    $('#panel_create').hide();
    $('#panel_update').hide();
    $('#panel_delete').show();
    
    $.ajax({
      url: "./delete.do", 
      type: "get", // or get
      cache: false,
      async: true, // true: 비동기
      dataType: "json", // 응답 형식, html, xml...
      // data: $('#frm').serialize(),  // 보내는 데이터
      data: 'boardno='+boardno,
      success: function(rdata) {
        var frm_delete = $('#frm_delete');
        $('#boardno', frm_delete).val(boardno);
        
        var str = '';        
        // 소속된 게시물 갯수를 출력 예정
        if (rdata.count_by_board > 0) {
          str = '<span style="color: #FF0000;">&apos;'+ rdata.name + '&apos; 카테고리에 [' + rdata.count_by_board + '] 건의 데이터가 등록되어있습니다.</span><br>';
          str += '카테고리에 등록된 데이터를 삭제해야 카테고리 삭제가 가능합니다.<br>';
          str += '<button type="button" onclick="delete_board_by_categrp('+categrpno+')">게시물 삭제</button>';
          str += '&nbsp;<button type="button" onclick="create_update_cancel();">취소</button>';
        } else {
          str = '[' + rdata.name + "] 카테고리를 삭제하시겠습니까?<br>";
          str += "삭제하면 복구 할 수 없습니다.<br>"
          str += '<button type="submit" id="submit">삭제</button>';
          str += '&nbsp;<button type="button" onclick="create_update_cancel();">취소</button>'; 
        }
        $('#msg_delete').html(str);
      },
      error: function(request, status, error) { // 응답 결과, 상태, 에러 내용
        var msg = 'ERROR<br><br>';
        msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
        msg += '<strong>request.responseText</strong><br>'+request.responseText + '<hr>';
        msg += '<strong>status</strong><br>'+status + '<hr>';
        msg += '<strong>error</strong><br>'+error + '<hr>';
          
        $('#main_panel').html(msg);
        $('#main_panel').show();
      }
     });

  }
  
  //카테고리에 등록된 게시물 모두 삭제
  function delete_board_by_categrp(categrpno) {
    $.ajax({
      url: "./delete_contents_by_board.do", 
      type: "post", // or get
      cache: false,
      async: true, // true: 비동기
      dataType: "json", // 응답 형식, html, xml...
      // data: $('#frm').serialize(),  // 보내는 데이터
      data: 'boardno='+boardno,
      success: function(rdata) {
        var frm_delete = $('#frm_delete');
        $('#boardno', frm_delete).val(boardno);
        
        var str = '';        
        // 소속된 카테고리 갯수를 출력 예정
        if (rdata.delete_by_board > 0) {
          str = '<span style="color: #FF0000;">&apos;'+ rdata.name + '&apos; 카테고리에서 [' + rdata.delete_by_board + '] 건의 데이터를 삭제했습니다.</span><br>';
          str += '카테고리 삭제를 계속 진행하시겠습니까?<br>';
          str += '<button type="button" onclick="deleteOne('+boardno+')">카테고리 그룹 삭제</button>';
          str += '&nbsp;<button type="button" onclick="create_update_cancel();">취소</button>';
        } else {
          str = '[' + rdata.name + "] 카테고리 관련 컨텐츠 삭제에 실패했습니다. 다시 시도하시겠습니까?<br>";
          str += "삭제하면 복구 할 수 없습니다.<br>"
          str += '<button type="button" onclick="delete_contents_by_board('+board+')">컨텐츠 삭제</button>';
          str += '&nbsp;<button type="button" onclick="create_update_cancel();">취소</button>'; 
        }
        $('#msg_delete').html(str);
      },
      error: function(request, status, error) { // 응답 결과, 상태, 에러 내용
        var msg = 'ERROR<br><br>';
        msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
        msg += '<strong>request.responseText</strong><br>'+request.responseText + '<hr>';
        msg += '<strong>status</strong><br>'+status + '<hr>';
        msg += '<strong>error</strong><br>'+error + '<hr>';

        $('#main_panel').html(msg);
        $('#main_panel').show();
      }
     });

  }
</script>
 
</head> 
 
<body>
<div class="main_wrapper">
  <c:import url="/menu/top.jsp"/>

  <c:import url="/menu/top_second.jsp"/>
  
  <div class="main_container">
    <div class="contents" align="center">
		  <DIV id='main_panel'></DIV>
		  
		  <div class="title_l">
        <h2>${categrpVO.name}</h2>
      </div>
      
      <DIV class="form-group" id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F5F5F5; width: 40%;'>
        <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
          <div class="form-group">
             <input type='hidden' name='categrpno' id='categrpno' value='${categrpVO.categrpno }'> 
            <label class="control-label" style="padding:5px 0px 5px 0px;">게시판 등록</label>
          </div>
          
  <%--         <div class="form-group">
            <label class="control-label" style="padding:5px 61% 5px 0px;">게시판</label>
          
            <select class="form-control" name='categrpno' id='categrpno' style="width: 70%; padding:0px 0px 3px 0px;">
              <c:forEach var="categrpVO" items="${categrp_list}">
                <option value='${categrpVO.categrpno }'>${categrpVO.name}</option>
              </c:forEach>
            </select>
          </div> --%>
          
          <div class="form-group">
            <label class="control-label" style="padding:5px 56% 5px 0px;">게시판 이름</label>
            <input class="form-control" type='text' name='name' id='name' size='10' value='' required="required" style="width:70%;">
            <input type='hidden' class="form-control" name='memberno' id='memberno' value='${user_memberno}' required="required">
          </div>
          
          <div class="button-group">
            <button class="btn btn-primary btn-info" type="button" id='submit' onclick="create();" style="background-image:none;">등록</button>
            <button class="btn btn-secondary btn-info" type="button" onclick="action_cancel();" style="background-image:none;">취소</button>
          </div>
        </FORM>
      </DIV>
        
      <DIV class="form-group" id='panel_update' style='padding: 10px 0px 10px 0px; background-color: #F5F5F5; width: 40%;'>  
        <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
          <div class="form-group">
            <label class="control-label" style="padding:5px 0px 5px 0px;">게시판 수정</label>
          </div>
          
          <div class="form-group">
            <input type='hidden' name='boardno' id='boardno' value=''> 
          
            <label class="control-label" style="padding:5px 61% 5px 0px;">게시판 </label>
            <select class="form-control" name='categrpno' id='categrpno' style="width:70%;">
              <c:forEach var="categrpVO" items="${categrp_list}">
                <option value='${categrpVO.categrpno }'>${categrpVO.name}</option>
              </c:forEach>
            </select>
          </div>   
          
          <div class="form-group">
            <label class="control-label" style="padding:5px 56% 5px 0px;">게시판 이름</label>
            <input class="form-control" type='text' name='name' id='name' size='15' value='' required="required" style="width:70%;">
            <input class="form-control" type='hidden' name='memberno' id='memberno' value='${user_memberno }' required="required">
          </div>
          
          <div class="button-group">
            <button class="btn btn-primary btn-info" type="submit" name="submit">저장</button>
            <button class="btn btn-secondary btn-info" type="button" onclick="action_cancel()">취소</button>
          </div>
        </FORM>
      </DIV>  
        
      <DIV class="form-group" id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #FFAAAA; width: 100%; text-align: center;'>
        <FORM name='frm_delete' id='frm_delete'>
          <input type='hidden' name='categrpno' id='categrpno' value=''>
          <input type='hidden' name='boardno' id='boardno' value=''>
          
          <div id='msg_delete'></div>
        </FORM>
      </DIV>
      
    <TABLE class='table table-striped table-hover' style='width: 90%; background-color: #F9F9F9; text-align: center;'>
      <colgroup>
        <col style='width: 10%;'/>
        <col style='width: 10%;'/>
        <col style='width: 35%;'/>
        <col style='width: 15%;'/>
        <col style='width: 10%;'/>
        <col style='width: 20%;'/>
     
      </colgroup>
      <thead>  
      <TR>
        <TH style='text-align: center ;'>번호</TH>
        <TH style='text-align: center ;'>그룹</TH>
        <TH style='text-align: center ;'>게시판</TH>
        <TH style='text-align: center ;'>관리자</TH>
        <TH style='text-align: center ;'>등록일자</TH>
        <TH style='text-align: center ;'>기타</TH>
        
      </TR>
      </thead>
		 
		  <tbody id='tbody_panel' data-nowPage='0' data-endPage='0'>
		  </tbody>
		  
		</TABLE>
		 
		 
		</DIV> <!-- content END -->
		<jsp:include page="/menu/bottom.jsp" flush='false' />
	</DIV> <!-- container END -->
</div>
</body>
 
</html> 
 