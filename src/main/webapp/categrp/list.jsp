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

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

    
<script type="text/javascript">
  $(function() {
    create_update_cancel();
    
    list();
  });

  function list() {
    $.ajax({
      url: "./list_json.do", // 요청을 보낼주소
      type: "get",
      cache: false,
      dataType: "json",
      success: function(rdata){
        var panel = '';
        
        for(index = 0; index < rdata.length; index++) {
			    panel += "<TR>";
			    panel += "  <TD style='text-align: center ;'>"+rdata[index].categrpno+"</TD>";
			    panel += "  <TD style='text-align: center ;'>";
			    if(rdata[index].classification == 1){
			      panel += "        공지사항"  ;
			    } else if(rdata[index].classification == 2) {
			      panel += "        게시판";
			    } else if(rdata[index].classification == 9) {
			      panel += "        기타";
			    }
			    panel += "    </TD>";
		      panel += "  <TD><A href='../board/list_by_categrp.do?categrpno="+rdata[index].categrpno+"'>"+rdata[index].name+"</A></TD>";
		      panel += " <TD>" + rdata[index].cnt + "</TD>";
		      panel += " <TD style='text-align: center;'>"+rdata[index].rdate.substring(0,10)+"</TD>";
		      panel += "  <TD style='text-align: center;'>";
		      panel += "   <A href='javascript:update("+rdata[index].categrpno+")'><span class='glyphicon glyphicon-edit' title='수정'></span></A>";
		      panel += "   <A href='javascript:deleteOne("+rdata[index].categrpno+")'><span class='glyphicon glyphicon-remove' title='삭제' ></A>";
		      panel += "  </TD>";
		      panel += "</TR>";
        }
        $('#tbody_panel').empty();
        $('#tbody_panel').append(panel);
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var panel = '';
        panel += "<DIV id='panel' class='popup1'>";
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
  
  //등록 처리
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
        panel += "<DIV id='panel' class='popup1' style='padding: 10px 0px 0px 0px;'>";
        panel += '  <font style="font-weight: bold;">알림</font><br><br>';
        for(index=0; index < rdata.msgs.length; index++) {
          panel += rdata.msgs[index]+'<br><br>';
        }
        panel += "  <button class='btn btn-default' type='button' onclick=\"$('#main_panel').hide();\">닫기</button>";
        panel += "</DIV>";
        
        create_update_cancel();
        
        list();  // 전체 게시판 목록
        
        $('#main_panel').html(panel);
        $('#main_panel').show();
        
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var panel = '';
        panel += "<DIV id='panel' class='popup1'>";
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
  
  function update(categrpno) {
    $('#panel_create').hide();
    $('#panel_update').show();
    $('#panel_delete').hide();
    
    $.ajax({
      url: "./update.do", 
      type: "get", // or get
      cache: false,
      async: true, // true: 비동기
      dataType: "json", // 응답 형식, html, xml...
      // data: $('#frm').serialize(),  // 보내는 데이터
      data: 'categrpno='+categrpno,
      success: function(rdata) {
        // alert(rdata);
        var frm_update = $('#frm_update');
        $('#classification', frm_update).val(rdata.classification);
        $('#categrpno', frm_update).val(rdata.categrpno);
        $('#name', frm_update).val(rdata.name);
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
  
  
  
  function create_update_cancel() {
    $('#main_panel').hide();
    $('#panel_update').hide();
    $('#panel_delete').hide();
    $('#panel_create').show();
    
    $('#frm_create')[0].reset();
  }
  
  // 삭제 폼
  function deleteOne(categrpno) {
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
      data: 'categrpno='+categrpno,
      success: function(rdata) {
        var frm_delete = $('#frm_delete');
        $('#categrpno', frm_delete).val(categrpno);
        
        var str = '';        
        // 소속된 카테고리 갯수를 출력 예정
        if (rdata.count_by_categrp > 0) {
          str = '<span style="color: #FF0000;">&apos;'+ rdata.name + '&apos; 카테고리에 [' + rdata.count_by_categrp + '] 건의 데이터가 등록되어있습니다.</span><br>';
          str += '카테고리에 등록된 데이터를 삭제해야 카테고리 그룹 삭제가 가능합니다.<br>';
          str += '<span class="button-group">';
          str += '<button class="btn btn-danger" type="button" onclick="delete_category_by_categrp('+categrpno+')">카테고리 삭제</button>';
          str += '&nbsp;<button class="btn btn-info" type="button" onclick="create_update_cancel();">취소</button>';
          str += '</span>';
        } else {
          str += '[' + rdata.name + "] 카테고리 그룹을 삭제하시겠습니까?<br>";
          str += "삭제하면 복구 할 수 없습니다.<br>";
          str += '<span class="button-group">';
          str += '<button class="btn btn-danger" type="submit" id="submit" style="background-image:none;">삭제</button>';
          str += '&nbsp';
          str += '<button class="btn btn-info" type="button" onclick="create_update_cancel();" style="background-image:none;">취소</button>'; 
          str += '</span>';
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
  
  // 카테고리 그룹에 등록된 카테고리 모두 삭제
  function delete_category_by_categrp(categrpno) {
    $.ajax({
      url: "./delete_category_by_categrp.do", 
      type: "post", // or get
      cache: false,
      async: true, // true: 비동기
      dataType: "json", // 응답 형식, html, xml...
      // data: $('#frm').serialize(),  // 보내는 데이터
      data: 'categrpno='+categrpno,
      success: function(rdata) {
        var frm_delete = $('#frm_delete');
        $('#categrpno', frm_delete).val(categrpno);
        
        var str = '';        
        // 소속된 카테고리 갯수를 출력 예정
        if (rdata.delete_by_categrp > 0) {
          str = '<span style="color: #FF0000;">&apos;'+ rdata.name + '&apos; 카테고리에서 [' + rdata.delete_by_categrp + '] 건의 데이터를 삭제했습니다.</span><br>';
          str += '카테고리 그룹 삭제를 계속 진행하시겠습니까?<br>';
          str += '<span class="button-group">'
          str += '<button class="btn btn-danger" type="button" onclick="deleteOne('+categrpno+')">카테고리 그룹 삭제</button>';
          str += '&nbsp;<button class="btn btn-info" type="button" onclick="create_update_cancel();">취소</button>';
          str += '</span>'
        } else {
          str = '[' + rdata.name + "] 카테고리 그룹 관련 카테고리 삭제에 실패했습니다. 다시 시도하시겠습니까?<br>";
          str += "삭제하면 복구 할 수 없습니다.<br>"
          str += '<span class="button-group">'
          str += '<button class="btn btn-danger" type="button" onclick="delete_board_by_categrp('+categrpno+')">카테고리 삭제</button>';
          str += '&nbsp;<button class="btn btn-info" type="button" onclick="create_update_cancel();">취소</button>'; 
          str += '</span>'
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
  
  <div class="main_container" align="center">
    
	  <DIV class="main_panel" id='main_panel'></DIV>
		  
		  <div class="title_l">
	      <h2>카테고리 그룹</h2>
		  </div>
		  
		  <DIV class="form-group" id='panel_create' style='padding: 10px 0px 10px 0px;  background-color: #F9F9F9; width: 40%;'>
		    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
		      <div class="form-group">
            <!-- <input type='hidden' name='categrpno' id='categrpno' value=''> -->
            <label class="control-label" style="padding:5px 0px 5px 0px;">카테고리 그룹 등록</label>
          </div>
          
          <div class="form-group">
            <label for="group-code" class="control-label" style="padding:3px 55% 3px 0px;">그룹 분류 코드</label>
            
            <select class="form-control" name='classification' id='classification' style="width:70%; padding:0px 0px 3px 0px;">
              <option value='1' selected="selected">1-공지사항</option>
              <option value='2'>2-게시판</option>
              <option value='9'>9-기타</option>
            </select>
          </div>
          
          <div class="form-group">
            <label for="group-name" class="control-label" style="padding:3px 59% 3px 0px;">그룹 이름</label>
            <input class="form-control" type='text' name='name' id='name' size='15' value='' required="required" style="width:70%;">
          </div>
          
          <div class="form-group">
            <button class="btn btn-primary btn-info" type="button" onclick="create();" style="background-image:none;">저장</button>
            <button class="btn btn-secondary btn-info" type="button" onclick="create_update_cancel();" style="background-image:none;">취소</button>
          </div>
		    </FORM> 
		  </DIV>
		
		  <DIV class="form-group" id='panel_update' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 40%;'>
		    <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
		      <div class="form-group">
	          <input type='hidden' name='categrpno' id='categrpno' value=''>
			      <label class="control-label" style="padding:5px 0px 5px 0px;">카테고리 그룹 수정</label>
		      </div>
		      
          <div class="form-group">
            <label for="group-code" class="control-label" style="padding:3px 55% 3px 0px;">그룹 분류 코드</label>
            
			      <select class="form-control" name='classification' id='classification' style="width:70%; padding:0px 0px 3px 0px;">
			        <option value='1' selected="selected">1-공지사항</option>
			        <option value='2'>2-게시판</option>
			        <option value='9'>9-기타</option>
			      </select>
          </div>
          
          <div class="form-group">
		        <label for="group-name" class="control-label" style="padding:3px 59% 3px 0px;">그룹 이름</label>
		        <input class="form-control" type='text' name='name' id='name' size='15' value='' required="required" style="width:70%;">
		      </div>
		      
		      <div class="form-group">
		        <button class="btn btn-primary btn-info" type="submit" id="submit" style="background-image:none;">저장</button>
		        <button class="btn btn-secondary btn-info" type="button" onclick="create_update_cancel();" style="background-image:none;">취소</button>
		      </div>
		    </FORM>
		  </DIV>
		  
		  <DIV class="form-group" id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 50%;'>
		    <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete.do'> 
		      <!-- <input type='hidden' name='categrpno' id='categrpno' value=''> -->
		
		      <DIV id='msg_delete' style='margin: 20px auto;'></DIV>
		    </FORM>
		  </DIV>
		
		  
		<TABLE class='table table-striped table-hover' style='width: 90%; background-color: #F9F9F9;'>
		  <colgroup>
		    <col style='width: 10%;'/>
		    <col style='width: 20%;'/>
		    <col style='width: 30%;'/>
		    <col style='width: 10%;'/>
		    <col style='width: 20%;'/>
		    <col style='width: 20%;'/>
		  </colgroup>
		
		  <thead>  
		  <TR>
		    <TH style='text-align: center ;'>카테고리 번호</TH>
		    <TH style='text-align: center ;'>그룹 분류</TH>
		    <TH>대분류명</TH>
		    <TH>카테고리 개수</TH>
		    <TH style='text-align: center ;'>등록일</TH>
		    <TH style='text-align: center ;'>기타</TH>
		  </TR>
		  </thead>
		  
		  <tbody id='tbody_panel' data-nowPage='0' data-endPage='0'>
		  </tbody>
		
		</TABLE>
		
	  <div class="main_bottom">
      <c:import url="/menu/bottom.jsp"/>
    </div>
    
	</DIV> <!-- container END -->
</div>
</body>

</html> 
 
 