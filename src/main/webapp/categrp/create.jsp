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

<script type="text/javascript">
  $(function(){

  });
</script>

</head> 

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 50%;'>

<DIV class='title_line' style='width: 40%;'>카테고리 그룹 등록</DIV>

<FORM name='frm' method='POST' action='./create.do'>
  <fieldset class='fieldset_basic'>
    <ul>
      <li class='li_none'>
        <label class='label' for='classification'>카테고리 그룹 분류 코드</label>
        <select name='classification' id='classification'>
          <option value='1' selected="selected">1-Blog</option>
          <option value='2'>2-Gallery</option>
          <option value='3'>3-Product</option>
          <option value='9'>9-기타</option>
        </select>
      </li>
      <li class='li_none'>
        <label class='label' for='name'>카테고리 그룹 이름</label>
        <input type='text' name='name' id='name' value='' required="required" autofocus="autofocus">
      </li>
      <li class='li_none'>
        <label class='label' for='seqno'>출력 순서</label>
        <input type='number' name='seqno' id='seqno' value='' required="required" placeholder="${seqno }" min="1" max="1000" step="1" style='width: 70%;'>
      </li>
      <li class='li_none'>
        <label class='label' for='visible'>출력 형식</label>
        <label>
          <input type='radio' name='visible' id='visible' value='Y' checked="checked"> Yes
        </label>
        <label>
          <input type='radio' name='visible' id='visible' value='N'> No
        </label>
      </li>
      <li class='li_right'>
        <button type="submit">등록</button>
        <button type="button" onclick="location.href='./list.do'">목록</button>
      </li>         
    </ul>
  </fieldset>
</FORM>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
  
   
