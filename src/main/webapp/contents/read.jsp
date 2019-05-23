<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>

<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">

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
    
    reply_by_contents(contentsno);
  });
  
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
        checkByte($('#frm_update_reply'));
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
        
        location.reload();
        
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
          panel += "<div id='comment-l' class='comment-l'>";
          panel += "  <div class='comment-meta'>";
          panel += "    <div class='comment-name-l'>";
          panel += "      <div class='comment-name'>" + rdata[index].id +"</div>";
          panel += "      <div class='comment-date'> " + rdata[index].rdate.substring(0, 19)+"</div>";
          panel += "    </div>";
          panel += "    <div class='comment-content'>";
          panel += "    " + rdata[index].content;
          panel += "    </div>";
          panel += "    <div class='comment-function'>";
          panel += "      <A href=\'javascript:reply_update_form("+rdata[index].replyno+")\'><span class='glyphicon glyphicon-edit' title='수정'></span></A>";  
          panel += "      <A href=\'javascript:deleteForm("+rdata[index].replyno+")\'><span class='glyphicon glyphicon-remove' title='삭제' ></span></A>"; 
          panel += "    </div>"
          panel += "  </div>";
          panel += "</div>";
        } 
        $('#comment').empty();
        $('#comment').append(panel);
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
  
  function checkByte(frm) {
    var limitByte = 1000;
    var totalByte = 0;
    var message = frm.content.value;

    for(var i = 0; i < message.length; i++) {
      var currentByte = message.charCodeAt(i);
      if(currentByte > 128) totalByte += 2;
      else totalByte++;
    }
    
    $('#messagebyte').text(totalByte);
    
    if(totalByte > limitByte) {
      alert(limitByte + "바이트까지 전송가능합니다.");
      
      frm.content.value() = message.substring(0, limitByte);
      currentByte = limitByte;
    }
  }
  
</script>
</head>

<body>
<div class="main_wrapper" align=center>

  <c:import url="/menu/top.jsp"/>
  
  <c:import url="/menu/top_second.jsp"/>
  
	<DIV class='main_container' style='width: 80%;'>
		<DIV class='contents'>   
		
		<div class="contents_aside">
		  <ASIDE style='float: left; color: white; padding: 20px 0px 10px 10px;'>
		    <A href='../board/list.do?categrpno=${boardVO.categrpno }' style="color: white;">카테고리</A>
		    <span style='font-size: 1.2em;'>></span>  
		    <A href='./list_by_board_search_paging.do?boardno=${boardVO.boardno }' style="color: white;">${boardVO.name }</A>
		  </ASIDE>
		  
		  <ASIDE style='float: right; color: white; padding: 20px 10px 10px 0px;'>
		    <A href="javascript:location.reload();" style="color: white;">새로고침</A>
		    <span class='menu_divide' >│</span> 
		    <A href='./create.do?boardno=${boardVO.boardno }' style="color: white;">등록</A>
		    <span class='menu_divide' >│</span> 
		    <A href='./list_by_board_search_paging.do?boardno=${boardVO.boardno }&nowPage=${param.nowPage}' style="color: white;">목록</A>
		    <span class='menu_divide' >│</span> 
		    <A href='./update.do?contentsno=${contentsVO.contentsno }&word=${param.word}&nowPage=${param.nowPage}' style="color: white;">수정</A>
		    <span class='menu_divide' >│</span> 
		    <A href='./delete.do?contentsno=${contentsVO.contentsno }&boardno=${boardVO.boardno }&word=${param.word}&nowPage=${param.nowPage}' style="color: white;">삭제</A>
		  </ASIDE> 
	  </div>
		  
	  <div class="page">
	    <div class="page_title">
        <p class="h1" style="font-weight: bold;">${contentsVO.name}</p>
        <strong class="page_id">${id}</strong> <span class='menu_divide' >│</span>
        <span class="page_date">${contentsVO.rdate.substring(0, 10)}</span> 
        <span style="color: gray;   float: right; padding-right: 15px;">댓글 ${count_reply}</span>
      </div>

      <DIV class="page_content_pic" id="page_content_pic">
        <c:forEach var ="fileVO"  items="${file_list }">
          <A href="javascript: panel_img('${fileVO.file }')"><IMG src='./storage/${fileVO.file }' style='width: 80%; margin-top: 2px;'></A>
        </c:forEach>
      </DIV>
      <DIV class="page_content">${contentsVO.content }</DIV>
	  </div>

    <div class="page_reply">
		  <div class="page_create_reply" id='panel_create'>
		    <div class="page_count_reply">
	        <p class="h4">
	          댓글
	          <small class="text-muted" style="color: gray;">총 <small class="text-muted" style="font-weight: bold; color: #16ae81;">${count_reply}</small>개</small>
	        </p>  
	        <p class="h5" style="margin: auto auto;">
             ${user_id }
          </p>
        </div>
        
        <div style="clear: both;"></div>
          
        <div class="md-form" style="width: 90%;">
			    <FORM name='frm_create_reply' id="frm_create_reply" method="post" action='./reply_create.do'>
			      <input type="hidden" name="nowPage" id="nowPage" value="${param.nowPage }">
			      <input type="hidden" name="word" id="word" value="${param.word }">
			      <input type="hidden" name="contentsno" value="${contentsVO.contentsno }">
			      <input type="hidden" name="memberno" value='${user_memberno }'>
			      
	          <textarea class="md-textarea form-control" id="content" name="content" rows="3"  onkeydown="checkByte(this.form);" style="resize: vertical;"></textarea>
			      <div style="float: right;"><p><em id="messagebyte">0</em>/1000 byte</p></div>			      
			      
			      <div style="clear: both;"></div>
			      
			      <div>
			        <input class="btn btn-success" type="submit" id="reply_create_submit" style="float: right; margin: 0px 0px 10px 0px;">
			      </div>
			    </FORM>
		    </div>
		  </div>
		  
		  <!--  수정폼은 항상 PK 전달한다. -->
		  <DIV class="page_update_reply" class="md-form" id='panel_update'>  
		    <div class="page_count_reply">
          <h4>
            댓글
            <small class="text-muted" style="color: gray;">총 <small class="text-muted" style="font-weight: bold; color: #16ae81;">${count_reply}</small>개</small>
          </h4>  
        </div>
        
        <div style="clear: both;"></div>
        
        <div class="page_reply_id">
          <p class="h5">${user_id }</p>
        </div>
		    
		    <div class="md-form" style="width: 90%;">
          <FORM name='frm_update_reply' id="frm_update_reply">
            <input type='hidden' name='replyno' id='replyno' value=''>             
            
            <textarea class="md-textarea form-control" id="content" name="content" rows="3"  onkeydown="checkByte(this.form);" style="resize: vertical;"></textarea>
            <div style="float: right;"><p><em id="messagebyte">0</em>/1000 byte</p></div>           
            <button class="btn btn-success" type="button" id="reply_update" onclick="reply_update_submit(${contentsVO.contentsno});">저장</button>
            <button class="btn btn-danger" type="button" onclick="action_cancel();">취소</button>
          </FORM>
        </div>
		  </DIV>
		  
		  <DIV class="page_delete_reply" id='panel_delete'>
		    <FORM name='frm_delete' id='frm_delete'>
		      <input type='hidden' name='replyno' id='replyno' value=''>
		      <div id='msg_delete'></div>
		    </FORM>
		  </DIV>
	  </div>
	  
	  <div style="clear: both;"></div>
	  
	  <div class="comment" id="comment" name="comment">
	  </div>
	 </DIV> <!-- contents END -->
	  
  <div class="main_bottom">
    <c:import url="/menu/bottom.jsp"/>
  </div>

	</DIV> <!-- container END -->
</div>
</body>

</html>


   