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
    imgResize()
  });

  //<div id='file1Panel'> 태그의 width에 맞추어 자동 축소
  function imgResize() {
    var file1 = $('#file1');
    var width = file1.width();
    // alert(width);
    // console.log("loading - width:" + loading + " - " + width);
    // console.log("screen.width-(screen.width * 0.3): " + screen.width-(screen.width * 0.3));
        
    if (file1 != null) {
      // 이미지 width가 화면의 70%보다 크다면
      if (width > screen.width-(screen.width * 0.4)) {
        // console.log("loading - width:" + loading + " - " + width);
        // file1.width(600); // 이미지 축소
        $('#file1Panel').attr('width', '100%');  // 할당된 영역을 100%로 설정함.
        file1.css('width', '900'); // <div id='file1Panel'> 태그의 width에 맞추어 자동 축소
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
</script>
</head>

<body>
<DIV class='container' style='width: 90%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>   

  <ASIDE style='float: left;'>
    <A href='../category/list.do?categrpno=${categoryVO.categrpno }'>카테고리</A>
    <span style='font-size: 1.2em;'>></span>  
    <A href='./list_by_category.do?categoryno=${categoryVO.categoryno }&word=${param.word}'>${categoryVO.title }</A>
  </ASIDE>
  <ASIDE style='float: right;'>
    <c:if test="${contentsVO.files.length() > 0 }">
      <A href='./download.do?contentsno=${contentsVO.contentsno}'>다운로드</A>
      <span class='menu_divide' >│</span> 
    </c:if>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do?categoryno=${categoryVO.categoryno }'>등록</A>
    <span class='menu_divide' >│</span> 
    <A href='./reply.do?categoryno=${categoryVO.categoryno }&contentsno=${contentsVO.contentsno }&word=${param.word}&nowPage=${param.nowPage}'>답변</A>
    <span class='menu_divide' >│</span> 
    <A href='./list_by_category_search_paging.do?categoryno=${categoryVO.categoryno }&word=${param.word}&nowPage=${param.nowPage}'>목록</A>
    <span class='menu_divide' >│</span> 
    <A href='./update.do?contentsno=${contentsVO.contentsno }&word=${param.word}&nowPage=${param.nowPage}'>수정</A>
    <span class='menu_divide' >│</span> 
    <A href='./delete.do?contentsno=${contentsVO.contentsno }&categoryno=${categoryVO.categoryno }&word=${param.word}&nowPage=${param.nowPage}'>삭제</A>
  </ASIDE> 
  
  <div class='menu_line'></div>

  <DIV id='main_panel'></DIV>
  
  <FORM name='frm' method="get" action='./update.do'>
      <input type="hidden" name="contentsno" value="${contentsVO.contentsno}">
      <fieldset class="fieldset">
        <ul>
          <li class="li_none">
            <span>${contentsVO.title}</span>
            (<span>${contentsVO.good}</span>)
            <span>${contentsVO.rdate.substring(0, 16)}</span>
            <DIV>
              <c:forEach var ="fileVO"  items="${file_list }">
                <A href="javascript: panel_img('${fileVO.file }')"><IMG src='./storage/${fileVO.thumb }' style='margin-top: 2px;'></A>
              </c:forEach>
            </DIV>
          </li>
          <li class="li_none">
            <DIV>${contentsVO.content }</DIV>
          </li>
          <li class="li_none">
            <DIV style='text-decoration: underline;'>검색어:(키워드) ${contentsVO.word }</DIV>
          </li>
        </ul>
      </fieldset>
  </FORM>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html>


   