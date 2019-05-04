<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Tea</title>
 
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com  /bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>


<script type="text/javascript">
  $(function(){
 
  });
</script>
</head> 
 
</head>
<body>
<div class="main_wrapper" align="center" style="background: #fafafa;">
  <c:import url="/menu/top.jsp"/>
  
  <c:import url="/menu/top_second.jsp"/>
	
	<div class="main_container">
	  <div class="row" style="width: 70%; margin: 15px 0px 10px 0px;">
	    <div class="col-sm-4">
	      <div class="row">
			    <div class="col-sm-4">
				    <div class="page_profile">
				      <img src="http://ssl.gstatic.com/accounts/ui/avatar_2x.png" class="img-rounded img-responsive" width="100px" height="100px"></img>
				    </div>
			    </div>
				  
				  <div class="col-sm-4">
				    <div class="page_id">
				      <p class="h2" style="margin: 0px 0px 0px 0px; display: inline-block;">${user_id }</p>
				    </div>
				    <div class="page_recently_searched">
				      3시간 전
				    </div>
			    </div>
	      </div>
			</div>
	  </div>
	  
	  <%-- <div class="row" style="width: 70%;">
	    <div class="col-sm-8" style="text-align: center;">
	      <div class="page_id_word">    
	        <c:forEach var="WordVO" begin="${fn:length(wordlist)-10 }"  end="${fn:length(wordlist) }" items="${wordlist }">
						<span class="badge badge-pill badge-info"><A class="badge badge-pill badge-info" href="#">${WordVO.word}</A></span>
	        </c:forEach>
	      </div>
	    </div>
	  </div> --%>
   
    <div class="page_divide">
    </div>
   
    <div class="page_result">
      <div class="page_side">
        <div class="result_box hover_box-1">
          <div class="result_box_image_box">
            <img class="result_box_image" src='${pageContext.request.contextPath}/image/twitter_logo.png'>

          </div>
          
          <div class="result_box_word">
            ${word}
          </div>
          
          <p class="arrow_box">안녕하세요</p>
        </div>
        
        <div class="result_box_freshtomato_box hover_box-1">
          
          <c:choose>
            <c:when test="${ftrate >= 75}">
              <img class="freshtomato_image" src='${pageContext.request.contextPath}/image/tomato_certified_fresh.png'>
            </c:when>
            <c:when test="${ftrate >= 50 }">
              <img class="freshtomato_image" src='${pageContext.request.contextPath}/image/tomato_fresh.png'>
            </c:when>
            <c:when test="${ftrate >= 25 }">
              <img class="freshtomato_image" src='${pageContext.request.contextPath}/image/tomato_ripe.png'>
            </c:when>
            <c:when test="${ftrate >= 0 }">
              <img class="freshtomato_image" src='${pageContext.request.contextPath}/image/tomato_rotten.png'>
            </c:when>
          </c:choose>
          
          
          <div class="freshtomato_rate">
            <p class="h2">${ftrate}%</p>
          </div>
          
          <p class="arrow_box">반갑습니다</p>
        </div>
        
      </div>
      <div class="page_real">
        <div id="chartContainer" data-allfreq='${allfreq}' data-rest='${rest}' data-maxfreq='${maxfreq}' data-word='${word}' 
                                    data-ar0='${ar0}' data-ar1='${ar1}' data-ar2='${ar2}' data-ar3='${ar3}' data-ar4='${ar4}' data-ar5='${ar5}' data-ar6='${ar6}' data-ar7='${ar7}'
                                    data-arr0='${arr0}' data-arr1='${arr1}' data-ar2='${arr2}' data-arr3='${arr3}' data-arr4='${arr4}' data-arr5='${arr5}' data-arr6='${arr6}' data-arr7='${arr7}'
                                    data-a0='${a0}' data-a1='${a1}' data-a2='${a2}' data-a3='${a3}' data-a4='${a4}' data-a5='${a5}' data-a6='${a6}' data-a7='${a7}' 
                      style="height: 350px; width: 500px;"></div>
        <button class="btn invisible" id="backButton">< Back</button>
        <script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
				<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
				<script type="text/javascript" src="../js/wordtimegraph.js"></script>
				
			<%-- 	<div class="page_crawling" id="page_crawling">
				  <div class="page_crawling_head">
				    실제 트위터에서 크롤링한 결과 (트윗과 RT를 합해 10개만 출력됩니다.):
				  </div>
				  <div style="clear: both;"></div>
				  <c:choose>
				    <c:when test="${fn:length(crawling_list)>=10 }">
						  <c:forEach var="CrawlingVO" begin="${fn:length(crawling_list)-10 }" end="${fn:length(crawling_list) }" items="${crawling_list }">
						    <div class="page_crawling_l">
							    ${CrawlingVO.content } 
							    ${CrawlingVO.rdate }
						    </div>
						  </c:forEach>
				    </c:when>
				    <c:otherwise>
              <c:forEach var="CrawlingVO" begin="0" end="${fn:length(crawling_list) }" items="${crawling_list }">
                <div class="page_crawling_l">
                  ${CrawlingVO.content } 
                  ${CrawlingVO.rdate }
                </div>
              </c:forEach>
            </c:otherwise>
				  </c:choose>
				</div> --%>
      </div>
		</div>
		

	</div>
</div>

<%-- 수정 요망 여기 만들 차례 검색어 별 회원 목록 
<FORM name='frm' id='frm' method='GET' action='../member_word/member_by_wordno.do' >
    <div class="form-group">
      특정 검색어를 검색한 회원 목록
      <input type="hidden" name="wordno" value="<%=(Integer)session.getAttribute("memberno")%>">
    </div>
    <button type="submit">조회</button>
</FORM>
 --%>
 
</body>
</html>