<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>
  .categrp_name{
    margin-left: 25px;
    font-weight: bold;
    list-style-image: url("${pageContext.request.contextPath}/category/images/reply3.jpg");
  }
  .category_title{
    margin-left: 45px;
    list-style-image: url("${pageContext.request.contextPath}/category/images/ting3.gif");
  }
</style>

<fieldset class='categrp_category' >
  <DIV style='margin-bottom: 0px; padding-bottom: 0px;'>▷ 카테고리</DIV>
  <DIV>
    <img src='${pageContext.request.contextPath}/category/images/title.png'>
    <A href="${pageContext.request.contextPath}/contents/list_all_category.do">전체 보기</A>
    <span style='font-size:0.9em; color: #555555;'>(${total_count })</span>
  </DIV>
  <UL class='categrp_category_list' style='line-height: 30px;'>
    <c:forEach var="title" items="${name_title_list }">
      ${title }
    </c:forEach>
   </UL>
</fieldset>
<br>





