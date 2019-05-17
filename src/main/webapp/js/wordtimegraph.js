
  
var totalVisitors = $(chartContainer).data("allfreq");
var rest = $(chartContainer).data("rest");
var maxfreq = $(chartContainer).data("maxfreq");
var word = $(chartContainer).data("word");
var word2 = "\""+$(chartContainer).data("word")+"\"";

var visitorsData = {
    "New vs Returning Visitors": [{
    click: visitorsChartDrilldownHandler,
    cursor: "pointer",
    explodeOnClick: false,
    innerRadius: "75%",
    legendMarkerType: "square",
    name: "전체검색어",
    radius: "100%",
    showInLegend: true,
    startAngle: 90,
    type: "doughnut",
    dataPoints: [
      // 도넛그래프의 legend
      { y: maxfreq, name: $(chartContainer).data("word"), color: "#E7823A" },
      { y: rest, name: "나머지 검색어", color: "#546BC1" }
    ]
  }],
  "검색한 검색어": [{
    color: "#E7823A",
    name: $(chartContainer).data("word"),
    type: "column",
    dataPoints: [
      { x: new Date($(chartContainer).data('ar7')), y: parseInt($(chartContainer).data('arr7')) },
      { x: new Date($(chartContainer).data('ar6')), y: parseInt($(chartContainer).data('arr6')) },
      { x: new Date($(chartContainer).data('ar5')), y: parseInt($(chartContainer).data('arr5')) },
      { x: new Date($(chartContainer).data('ar4')), y: parseInt($(chartContainer).data('arr4')) },
      { x: new Date($(chartContainer).data('ar3')), y: parseInt($(chartContainer).data('arr3')) },
      { x: new Date($(chartContainer).data('ar2')), y: parseInt($(chartContainer).data('arr2')) },
      { x: new Date($(chartContainer).data('ar1')), y: parseInt($(chartContainer).data('arr1')) },
      { x: new Date($(chartContainer).data('ar0')), y: parseInt($(chartContainer).data('arr0')) }
      
    ]
  }],
  "나머지 검색어": [{
    color: "#546BC1",
    name: "나머지 검색어",
    type: "column",
    dataPoints: [
      { x: new Date($(chartContainer).data('ar7')), y: parseInt($(chartContainer).data('a7')) },
      { x: new Date($(chartContainer).data('ar6')), y: parseInt($(chartContainer).data('a6')) },
      { x: new Date($(chartContainer).data('ar5')), y: parseInt($(chartContainer).data('a5')) },
      { x: new Date($(chartContainer).data('ar4')), y: parseInt($(chartContainer).data('a4')) },
      { x: new Date($(chartContainer).data('ar3')), y: parseInt($(chartContainer).data('a3')) },
      { x: new Date($(chartContainer).data('ar2')), y: parseInt($(chartContainer).data('a2')) },
      { x: new Date($(chartContainer).data('ar1')), y: parseInt($(chartContainer).data('a1')) },
      { x: new Date($(chartContainer).data('ar0')), y: parseInt($(chartContainer).data('a0')) }
    ]
  }]
};

var newVSReturningVisitorsOptions = {
  animationEnabled: true,
  backgroundColor: "#F9F9F9",
  theme: "light2",
  title: {
    text: "최근 7일 간 검색 횟수 동향"
  },
  subtitles: [{
    text: "그래프를 클릭해보세요.",
    backgroundColor: "#2eacd1",
    fontSize: 16,
    fontColor: "white",
    padding: 5
  }],
  legend: {
    fontFamily: "calibri",
    fontSize: 14,
    itemTextFormatter: function (e) {
      return e.dataPoint.name + ": " + Math.round(e.dataPoint.y / totalVisitors * 100) + "%";  
    }
  },
  data: []
};

var visitorsDrilldownedChartOptions = {
  animationEnabled: true,
  backgroundColor: "#F9F9F9",
  theme: "light2",
  axisX: {
    labelFontColor: "#717171",
    lineColor: "#a2a2a2",
    tickColor: "#a2a2a2",
    fontSize: 5,
    labelFontSize: 8
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

var chart = new CanvasJS.Chart("chartContainer", newVSReturningVisitorsOptions);
chart.options.data = visitorsData["New vs Returning Visitors"];
chart.render();

function visitorsChartDrilldownHandler(e) {
  chart = new CanvasJS.Chart("chartContainer", visitorsDrilldownedChartOptions);
  // 막대그래프의 데이터
  chart.options.data = visitorsData["검색한 검색어"];
  // 막대그래프의 제목
  chart.options.title = { text: $(chartContainer).data("word") }
  chart.render();
  $("#backButton").toggleClass("invisible");
}


$("#backButton").click(function() { 
  $(this).toggleClass("invisible");
  chart = new CanvasJS.Chart("chartContainer", newVSReturningVisitorsOptions);
  chart.options.data = visitorsData["New vs Returning Visitors"];
  chart.render();
});

