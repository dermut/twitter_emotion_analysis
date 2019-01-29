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
$(function(){

});
</script>

<script type="text/javascript">
</script>
</head>

<body>
<div class="main_wrapper" align="center" >
  <c:import url="/menu/top.jsp"/>
  
  <c:import url="/menu/top_second.jsp"/>
  
	<DIV class='main_container' style="width: 80%;">
	<DIV class='contents'  style="width: 100%;">     
	
    <div class="title_l">
      <h2>${boardVO.name }</h2>
    </div>
      
	  <form class="search-form" name='frm' id='frm' method="get" action="./list_by_board_search_paging.do" style="width: 95%; display: inline-block;">
		  <ASIDE style='color: white; float: left; padding: 10px 0px 13px 0px;'>
		    <A class="member_aside_a" href='../board/list.do'>게시판 목록</A>
		    >  
		    <A class="member_aside_a" href='./list_by_board_search_paging.do?boardno=${boardVO.boardno }'>${boardVO.name }</A>
		
		    <c:if test="${param.word.length() > 0}"> 
		      >
		      [${param.word}] 검색 목록(${search_count } 건) 
		    </c:if>
		  </ASIDE>
		  
		  <ASIDE style='color: white; float: right; padding: 0px 0px 13px 0px;'>
		    <A class="member_aside_a" href="javascript:location.reload();">새로고침</A>
		 
		    <c:if test="${sessionScope.id ne null }">
		      <span class='menu_divide' >│</span> 
		      <A class="member_aside_a" href='./create.do?boardno=${boardVO.boardno }'>등록</A>
		    </c:if>
		    
		    <input type='hidden' name='boardno' id='boardno' value='${boardVO.boardno }'>
		    <span class='menu_divide' >│</span> 
		    <c:choose>
		      <c:when test="${param.word != '' }">
		        <input class="form-control" type='text' name='word' id='word' value='${param.word }' style='width: 35%; display:inline-block;' placeholder="검색">
		      </c:when>
		      <c:otherwise>
		        <input class="form-control" type='text' name='word_find' id='word_find' value='' style='width: 35%; display:inline-block;' placeholder="검색">
		      </c:otherwise>
		    </c:choose>
		    <button class="btn btn-default" type='submit'>검색</button>
		    <button class="btn btn-default" type='button' 
		                 onclick="location.href='./list_by_board_search_paging.do?boardno=${boardVO.boardno }'">전체 보기</button>
		  </ASIDE>
	  </form>
	    
	  <div class='menu_line' style='clear: both;'></div>       
	
	  <TABLE class='table table-striped table-hover' style='background-color: #F9F9F9; text-align: center; box-shadow: 5px 5px 10px gray;'>
	      <colgroup>
	        <col style="width: 10%;"></col>
	        <col style="width: 50%;"></col>
	        <col style="width: 20%;"></col>
	        <col style="width: 10%;"></col>
	        <col style="width: 10%;"></col>
	      </colgroup>
	      <%-- table 컬럼 --%>
	      <thead>
	        <tr>
	          <th style="text-align: center;">썸네일</th>
	          <th style="text-align: center;">제목</th>
	          <th style="text-align: center;">등록일</th>
	          <th style="text-align: center;">아이디</th>
	          <th style="text-align: center;">기타</th>
	        </tr>
	      </thead>
	      
	      <%-- table 내용 --%>
	      <tbody>
	        <c:forEach var="contentsVO" items="${list }">
	          <tr>
	            <td style='vertical-align: middle;'>
	              <c:choose>
	                <c:when test="${contentsVO.thumb != null}">
	                  <IMG id='thumb' src='./storage/${contentsVO.thumb }'> <!-- 이미지 파일명 출력 -->
	                </c:when>
	                <c:otherwise>
	                  <!-- 파일이 존재하지 않는 경우 -->
	                  <IMG src='./images/none1.jpg' style='width: 120px; height: 80px;'>
	                </c:otherwise>
	              </c:choose>
	            </td>   
	                     
	            <td style='vertical-align: middle;'>
	               
	              <a href="./read.do?contentsno=${contentsVO.contentsno}&boardno=${contentsVO.boardno}&word=${param.word}&nowPage=${param.nowPage}" style="color:#1e2022;">${contentsVO.name}</a> <em style="color: #16ae81;">[${contentsVO.count_reply}]</em>
	            </td> 
	
	            <td style='vertical-align: middle;'>${contentsVO.rdate.substring(0, 10)}</td>
	            <td style='vertical-align: middle;'>${contentsVO.id}</td>
	            <td style='vertical-align: middle;'>
	              <a href="./update.do?contentsno=${contentsVO.contentsno}&boardno=${contentsVO.boardno}&nowPage=${param.nowPage}&word=${param.word}"><img src="./images/update.png" title="수정" border='0'/></a>
	              <a href="./delete.do?contentsno=${contentsVO.contentsno}&boardno=${contentsVO.boardno}&nowPage=${param.nowPage}&word=${param.word}"><img src="./images/delete.png" title="삭제"  border='0'/></a>
	            </td>
	          </tr>
	        </c:forEach>
	        
	      </tbody>
	  </table>
	  <DIV class='bottom_menu'>${paging }</DIV>
	  <br><br>

	</DIV> <!-- content END -->
	
	<div class="main_bottom">
    <c:import url="/menu/bottom.jsp"/>
  </div>
  
	</DIV> <!-- container END -->
</div>
</body>

</html>

