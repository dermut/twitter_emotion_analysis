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
    
  });
  
  function update(categrpno) {
    $('#panel_create').hide();
    $('#panel_update').show();
    
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
    $('#panel_update').hide();
    $('#panel_delete').hide();
    $('#panel_create').show();
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
          str += '<button type="button" onclick="delete_board_by_categrp('+categrpno+')">카테고리 삭제</button>';
          str += '&nbsp;<button type="button" onclick="create_update_cancel();">취소</button>';
        } else {
          str = '[' + rdata.name + "] 카테고리 그룹을 삭제하시겠습니까?<br>";
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
  
  // 카테고리 그룹에 등록된 카테고리 모두 삭제
  function delete_board_by_categrp(categrpno) {
    $.ajax({
      url: "./delete_board_by_categrp.do", 
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
          str += '<button type="button" onclick="deleteOne('+categrpno+')">카테고리 그룹 삭제</button>';
          str += '&nbsp;<button type="button" onclick="create_update_cancel();">취소</button>';
        } else {
          str = '[' + rdata.name + "] 카테고리 그룹 관련 카테고리 삭제에 실패했습니다. 다시 시도하시겠습니까?<br>";
          str += "삭제하면 복구 할 수 없습니다.<br>"
          str += '<button type="button" onclick="delete_board_by_categrp('+categrpno+')">카테고리 삭제</button>';
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
<DIV class='container' style='width: 100%;'>
<c:import url="/menu/top.jsp"  />
<DIV class='content'>
  <!-- 우선 순위 증가 감소 폼 -->
  <FORM name='frm_seqno' id='frm_seqno' method='post' action=''>
    <input type='hidden' name='categrpno' id='categrpno' value=''>
  </FORM>
  
  <DIV id='main_panel'></DIV>
  
  <DIV class='title_line'>카테고리 그룹</DIV>

  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
        
      <label for='classification'>그룹 분류 코드</label>
      <select name='classification' id='classification'>
        <option value='1' selected="selected">1-공지사항</option>
        <option value='2'>2-게시판</option>
        <option value='9'>9-기타</option>
      </select>
          
      <label for='name'>그룹 이름</label>
      <input type='text' name='name' id='name' value='' required="required" style='width: 25%;'>
       
      <button type="submit" id='submit'>등록</button>
      <button type="button" onclick="create_update_cancel();">취소</button>
    </FORM>
  </DIV>

  <DIV id='panel_update' style='display: none; padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_update' id='frm_update' method='POST' 
                action='./update.do'>
      <input type='hidden' name='categrpno' id='categrpno' value=''>

      <label for='classification'>그룹 분류 코드</label>
      <select name='classification' id='classification'>
        <option value='1' selected="selected">1-공지사항</option>
        <option value='2'>2-게시판</option>
        <option value='9'>9-기타</option>
      </select>
            
      <label for='name'>그룹 이름</label>
      <input type='text' name='name' id='name' size='15' value='' required="required" style='width: 30%;'>

      <button type="submit" id='submit'>저장</button>
      <button type="button" onclick="create_update_cancel();">취소</button>
    </FORM>
  </DIV>

  <DIV id='panel_delete' style='display: none; padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_delete' id='frm_delete' method='POST' 
                action='./delete.do'> 
      <input type='hidden' name='categrpno' id='categrpno' value=''>

      <DIV id='msg_delete' style='margin: 20px auto;'></DIV>
    </FORM>
  </DIV>

  
<TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 20%;'/>
    <col style='width: 30%;'/>
    <col style='width: 20%;'/>
    <col style='width: 20%;'/>
  </colgroup>

  <thead>  
  <TR>
    <TH style='text-align: center ;'>카테고리 번호</TH>
    <TH style='text-align: center ;'>그룹 분류</TH>
    <TH>대분류명</TH>
    <TH style='text-align: center ;'>등록일</TH>
    <TH style='text-align: center ;'>기타</TH>
  </TR>
  </thead>
  <c:forEach var="categrpVO" items="${list }">
  <TR>
    <TD style='text-align: center ;'>${categrpVO.categrpno }</TD>
    <TD style='text-align: center ;'>
      <c:choose>
        <c:when test="${categrpVO.classification == 1 }">
          공지사항     
        </c:when>
        <c:when test="${categrpVO.classification == 2 }">
          게시판
        </c:when>
        <c:when test="${categrpVO.classification == 9 }">
          기타
        </c:when>
      </c:choose>
    </TD>
    <TD><A href="../board/list_by_categrp.do?categrpno=${categrpVO.categrpno }">${categrpVO.name }</A></TD>
    <TD style='text-align: center ;'>${categrpVO.rdate.substring(0, 10) }</TD>
    <TD>
      <A href="javascript:update(${categrpVO.categrpno })"><IMG src='./images/update.png' title='수정'></A>
      <A href="javascript:deleteOne(${categrpVO.categrpno })"><IMG src='./images/delete.png' title='삭제'></A>
    </TD>
  </TR>
  </c:forEach> 

</TABLE>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" />
</DIV> <!-- container END -->
</body>

</html> 
 
 