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
$(function(){

});
</script>

<script type="text/javascript">
</script>
</head>

<body>
<DIV class='container' style="width: 100;">
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 100%;'>     
  <form name='frm' id='frm' method="get" action="./list_by_board_search_paging.do">
  <ASIDE style='float: left;'>
    <A href='../board/list.do'>게시판 목록</A>
    >  
    <A href='./list_by_board_search_paging.do?boardno=${boardVO.boardno }'>${boardVO.name }</A>

    <c:if test="${param.word.length() > 0}"> 
      >
      [${param.word}] 검색 목록(${search_count } 건) 
    </c:if>

  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
 
    <c:if test="${sessionScope.id ne null }">
      <span class='menu_divide' >│</span> 
      <A href='./create.do?boardno=${boardVO.boardno }'>등록</A>
    </c:if>
    
    <input type='hidden' name='boardno' id='boardno' value='${boardVO.boardno }'>
    <span class='menu_divide' >│</span> 
    <c:choose>
      <c:when test="${param.word != '' }">
        <input type='text' name='word' id='word' value='${param.word }' style='width: 35%;'>
      </c:when>
      <c:otherwise>
        <input type='text' name='word_find' id='word_find' value='' style='width: 35%;'>
      </c:otherwise>
    </c:choose>
    <button type='submit'>검색</button>
    <button type='button' 
                 onclick="location.href='./list_by_board_search_paging.do?boardno=${boardVO.boardno }'">전체 보기</button>
  </ASIDE>
  </form>
    
  <div class='menu_line' style='clear: both;'></div>       

  <table class="table table-striped" style='width: 100%;'>
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
          <th>파일</th>
          <th>제목</th>
          <th>등록일</th>
          <th>아이디</th>
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
              
              <a href="./read.do?contentsno=${contentsVO.contentsno}&boardno=${contentsVO.boardno}&word=${param.word}&nowPage=${param.nowPage}">${contentsVO.name}</a> 
            </td> 

            <td style='vertical-align: middle;'>${contentsVO.rdate.substring(0, 10)}</td>
            <td style='vertical-align: middle;'>${contentsVO.memberno}</td>
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
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html>

