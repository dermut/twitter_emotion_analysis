<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" http-equiv="Content-Type">
<style>
/* // 뒤로가기 버튼 css */
#backButton {
  border-radius: 4px;
  padding: 8px;
  border: none;
  font-size: 16px;
  background-color: #2eacd1;
  color: white;
  position: absolute;
  top: 10px;
  right: 10px;
  cursor: pointer;
}
.invisible {
  display: none;
}
</style>

</head>
<body>



  <div id="chartContainer" style="height: 370px; width: 100%;"></div>
  <button class="btn invisible" id="backButton">&lt; Back</button>
  <script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
  <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
  
  <script type="text/javascript"> // 자바스크립트
window.onload = function() {

// 전체에서 그 단어로 하려면 3개유지, 그 단어만 보여주려면 2개로 축소  
var dps = [[],[],[]];
// ${allfreq}
var allFreq = ${allfreq};
var maxFreq = ${maxfreq};
 
var yValue;
var xValue;
var name;
var color;

// 클릭 후에 차트에 반복문으로 데이터 삽입 
<c:forEach items="${dataPointsList}" var="dataPoints" varStatus="loop">
  <c:forEach items="${dataPoints}" var="dataPoint">
    yValue = parseInt("${dataPoint.y}");
    xValue = parseInt("${dataPoint.x}");    
    name = "${dataPoint.name}";
    color = "${dataPoint.color}";
    dps[parseInt("${loop.index}")].push({
      x : xValue,
      y : yValue,
      name: name,
      color: color
    });
  </c:forEach>
</c:forEach>

// 차트 관련 내용 (제목 수정 가능, 변수 이름 수정)
var wordFreqChart = {
  "Main Title": [{
    click: wordFreqChartHandler,
    cursor: "pointer",
    explodeOnClick: false,
    innerRadius: "75%",
    legendMarkerType: "square",
    name: "Main Title",
    radius: "100%",
    showInLegend: true,
    startAngle: 90,
    type: "doughnut",
    dataPoints: dps[0]
  }],
  "SearchWord": [{
    color: "#E7823A",
    name: "SearchWord",
    /* xValueType: "dateTime", */
    type: "column",
    dataPoints: dps[1]
  }],
  "AllWord": [{
    color: "#546BC1",
    name: "AllWord",
    /* xValueType: "dateTime", */
    type: "column",
    dataPoints: dps[2]
  }]  
};

console.log(wordFreqChart["Main Title"])
var mainOptions = {
  animationEnabled: true,
  theme: "light2",
  title: {
    // 제일 큰 제목 정하기(전체 검색어 비율)
    text: "Main Title"
  },
  subtitles: [{
    // 서브 제목 정하기(검색어 이름 들어가게 수정)
    text: "Click on Any Segment to Drilldown",
    backgroundColor: "#2eacd1",
    fontSize: 16,
    fontColor: "white",
    padding: 5
  }],
  legend: {
    // 아래 범주에 관련된 부분 사용하려면 전체에서 차지하는 부분이 좋을 듯
    fontFamily: "calibri",
    fontSize: 14,
    itemTextFormatter: function (e) {
      return e.dataPoint.name + ": " + Math.round(e.dataPoint.y / allFreq * 100) + "%";  
    }
  },
  data: []
};
 
var chartOptions = {
  animationEnabled: true,
  theme: "light2",
  axisX: {
    labelFontColor: "#717171",
    lineColor: "#a2a2a2",
    tickColor: "#a2a2a2"
  },
  axisY: {
    gridThickness: 0,
    includeZero: false,
    labelFontColor: "#717171",
    lineColor: "#a2a2a2",
    tickColor: "#a2a2a2",
    lineThickness: 1
  },
  data: []
};
 
var chart = new CanvasJS.Chart("chartContainer", mainOptions);
chart.options.data = wordFreqChart["Main Title"];
chart.render();
 
function wordFreqChartHandler(e) {
  chart = new CanvasJS.Chart("chartContainer", chartOptions);
  chart.options.data = wordFreqChart[e.dataPoint.name];
  chart.options.title = { text: e.dataPoint.name }
  alert('두번째 차트 그리기 전');
  chart.render();
  alert('두번째 차트 그리기 후');
  $("#backButton").toggleClass("invisible");
}
 
$("#backButton").click(function() { 
  $(this).toggleClass("invisible");
  chart = new CanvasJS.Chart("chartContainer", mainOptions);
  chart.options.data = wordFreqChart["Main Title"];
  chart.render();
});
 
}
</script>
</body>
</html>                              