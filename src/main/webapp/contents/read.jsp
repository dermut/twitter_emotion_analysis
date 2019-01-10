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

<script type="text/javascript">
  $(document).ready(function(){ // window.onload = function() { ... }
    var tmp = $(location).attr('search').split("contentsno=");
    var tmp1 = tmp[1].split("&");
    var contentsno = tmp1[0];
    
    action_cancel();
    
    imgResize();
    reply_by_contents(contentsno);
  });

  //<div id='photoPanel'> 태그의 width에 맞추어 자동 축소
  function imgResize() {
    var photo = $('#photo');
    var width = photo.width();
        
    if (photo != null) {
      // 이미지 width가 화면의 70%보다 크다면
      if (width > screen.width-(screen.width * 0.4)) {
        $('#photoPanel').attr('width', '100%');  // 할당된 영역을 100%로 설정함.
        photo.css('width', '900'); // <div id='photoPanel'> 태그의 width에 맞추어 자동 축소
      } else {
        // 작은 이미지는 그대로 출력
      }
    }

  }
  
  function panel_img(file){
    var panel = '';
    panel += "<DIV id='panel' class='popup_img' style='width: 80%;'>";
    panel += "  <A href=\"javascript: $('#main_panel').hide();\"><IMG src='./storage/"+file+"' style='width: 100%;'></A>";
    panel += "</DIV>";
    
    $('#main_panel').html(panel);
    $('#main_panel').show();
  }
  
  //등록 처리
  function reply_create() {
    $.ajax({
      url: "./reply_create_json.do", // 요청을 보낼주소
      type: "post",  // or get
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: $('#frm_create_reply').serialize(), 
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
        
        action_cancel();
        
        reply_by_contents(contentsno);
        
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

  function reply_update_form(replyno) {
    $('#panel_create').hide();
    $('#panel_update').show();
    $('#panel_delete').hide();
    
    $.ajax({
      url: "./reply_update.do", // 요청을 보낼주소
      type: "get",  // or get
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: 'replyno=' + replyno,  // $('#frm').serialize(), 
      // Ajax 통신 성공, JSP 정상 처리
      success: function(rdata) { // callback 함수
        var frm_update = $('#frm_update_reply');
        $('#replyno', frm_update).val(rdata.replyno);
        $('#content', frm_update).val(rdata.content); // SELECT tag
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
  function reply_update_submit(contentsno) {
    $.ajax({
      url: "./reply_update_json.do", // 요청을 보낼주소
      type: "post",  // or get
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: $('#frm_update_reply').serialize(), 
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
        
        action_cancel();
        
        reply_by_contents(contentsno);  // 전체 게시판 목록
        
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

  function deleteForm(replyno) {
    $('#panel_create').hide();
    $('#panel_update').hide();
    $('#panel_delete').show();
    
    $.ajax({
      url: "./reply_delete.do", // 요청을 보낼주소
      type: "get",  // or get
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: 'replyno=' + replyno,
      // Ajax 통신 성공, JSP 정상 처리
      success: function(rdata) { // callback 함수
        var frm_delete = $('#frm_delete');
        $('#replyno', frm_delete).val(rdata.replyno); 
        
        var str = '';        
        // 소속된 카테고리 갯수를 출력 예정
        str = "댓글을 삭제하시겠습니까?<br>";
        str += "삭제하면 복구 할 수 없습니다.<br>"
        str += '<button type="button" id="submit" onclick="delete_submit(' + ${contentsVO.contentsno} + ');">삭제</button>';
        str += '&nbsp;<button type="button" onclick="action_cancel();">취소</button>'; 
       $('#msg_delete').html(str);
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

  // 삭제 처리
  function delete_submit(contentsno) {
    $.ajax({
      url: "./reply_delete.do", // 요청을 보낼주소
      type: "post",  // or get
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: $('#frm_delete').serialize(), 
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
        
        action_cancel();  
        
        reply_by_contents(contentsno);
        
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
  
  function action_cancel() {
    $('#panel_create').show();
    $('#panel_update').hide();
    $('#panel_delete').hide();
  }
  
  
  function reply_by_contents(contentsno) {
    $.ajax({
      url: "./reply_by_contents.do", // 요청을 보낼주소
      type: "get",  // or get
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: "contentsno=" + contentsno,
      // Ajax 통신 성공, JSP 정상 처리
      success: function(rdata) { // callback 함수
        var panel = '';

        for(index=0; index < rdata.length; index++) {
          panel += "<TR>";
          panel += "<TD style='text-align: center ;'>"+(index+1)+"</TD>";
          panel += "<TD>"+rdata[index].memberno+"</TD>";
          panel += "<TD>"+rdata[index].content+"</TD>";
          panel += "<TD>"+rdata[index].rdate.substring(0, 10)+"</TD>";
          panel += "<TD>"
          panel += "  <A href=\"javascript:reply_update_form("+rdata[index].replyno+")\"><IMG src='./images/update.png' name='수정'></A>";  
          panel += "  <A href=\"javascript:deleteForm("+rdata[index].replyno+")\"><IMG src='./images/delete.png' name='삭제'></A>"; 
          panel += "</TD>";
          panel += "</TR>";
        } 
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
  
</script>
</head>

<body>
<DIV class='container' style='width: 90%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>   

  <ASIDE style='float: left;'>
    <A href='../board/list.do?categrpno=${boardVO.categrpno }'>카테고리</A>
    <span style='font-size: 1.2em;'>></span>  
    <A href='./list_by_board.do?boardno=${boardVO.boardno }'>${boardVO.name }</A>
  </ASIDE>
  <ASIDE style='float: right;'>
    <c:if test="${contentsVO.photo.length() > 0 }">
      <A href='./download.do?contentsno=${contentsVO.contentsno}'>다운로드</A>
      <span class='menu_divide' >│</span> 
    </c:if>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do?boardno=${boardVO.boardno }'>등록</A>
    <span class='menu_divide' >│</span> 
    <A href='./reply.do?boardno=${boardVO.boardno }&contentsno=${contentsVO.contentsno }&word=${param.word}&nowPage=${param.nowPage}'>답변</A>
    <span class='menu_divide' >│</span> 
    <A href='./list_by_board_search_paging.do?boardno=${boardVO.boardno }&nowPage=${param.nowPage}'>목록</A>
    <span class='menu_divide' >│</span> 
    <A href='./update.do?contentsno=${contentsVO.contentsno }&word=${param.word}&nowPage=${param.nowPage}'>수정</A>
    <span class='menu_divide' >│</span> 
    <A href='./delete.do?contentsno=${contentsVO.contentsno }&boardno=${boardVO.boardno }&word=${param.word}&nowPage=${param.nowPage}'>삭제</A>
  </ASIDE> 
  
  <div class='menu_line'></div>

  <DIV id='main_panel'></DIV>
  
  <fieldset class="fieldset">
    <ul>
      <li class="li_none">
        <span>${contentsVO.name}</span>
      <li>
       <strong>${contentsVO.memberno}</strong>
      </li>
        <span>${contentsVO.rdate.substring(0, 10)}</span>
        <DIV>
          <c:forEach var ="fileVO"  items="${file_list }">
            <A href="javascript: panel_img('${fileVO.file }')"><IMG src='./storage/${fileVO.thumb }' style='margin-top: 2px;'></A>
          </c:forEach>
        </DIV>
      </li>
      <li class="li_none">
        <DIV>${contentsVO.content }</DIV>
      </li>
    </ul>
  </fieldset>
  
  <DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #FFAAAA; width: 100%; text-align: center;'>
    <FORM name='frm_delete' id='frm_delete'>
      <input type='hidden' name='replyno' id='replyno' value=''>
      <div id='msg_delete'></div>
    </FORM>
  </DIV>
  
  <div id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #DDDDDD; width: 100%; text-align: center;'>
    <FORM name='frm_create_reply' id="frm_create_reply" method="post" action='./reply_create.do'>
	    <input type="hidden" name="nowPage" id="nowPage" value="${param.nowPage }">
	    <input type="hidden" name="word" id="word" value="${param.word }">
	    <input type="hidden" name="contentsno" value="${contentsVO.contentsno }">
	    <input type="hidden" name="memberno" value=1> <!-- 수정해야 함. 로그인되어있는 아이디! -->
	      <ul>
		      <li>
			      <textarea id="content" name="content" rows="5" cols="30"></textarea>
		      </li>
	      </ul>
	     <input type="submit" id="reply_create_submit">
	  </FORM>
  </div>
  
  <!--  수정폼은 항상 PK 전달한다. -->
  <DIV id='panel_update' style='padding: 10px 0px 10px 0px; background-color: #DDDDDD; width: 100%; text-align: center;'>  
    <FORM name='frm_update_reply' id='frm_update_reply' method='POST' action='./reply_update.do'>
      <input type='hidden' name='replyno' id='replyno' value=''> 
      <ul>
        <li>
          <textarea id="content" name="content" rows="5" cols="30"></textarea>
        </li>
      </ul>
      <button type="button" id="reply_update" onclick="reply_update_submit(${contentsVO.contentsno});">저장</button>
      <button type="button" onclick="action_cancel();">취소</button>
    </FORM>
  </DIV>
  
  <TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 50%;'/>
    <col style='width: 10%;'/>
    <col style='width: 20%;'/>
  </colgroup>
  
  <thead>  
  <TR>
    <TH style='text-align: center ;'>번호</TH>
    <TH style='text-align: center ;'>아이디</TH>
    <TH style='text-align: center ;'>내용</TH>
    <TH style='text-align: center ;'>등록일자</TH>
    <TH style='text-align: center ;'>기능</TH>
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


   