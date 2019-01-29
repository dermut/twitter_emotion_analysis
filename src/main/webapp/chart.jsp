<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>


<!DOCTYPE HTML>
<html>
<head>

<!--  <script>
window.onload = function () {
  
var totalVisitors = ${allfreq};
var rest = ${rest};
var word = $(chartContainer).data("word");

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
			{ y: "${maxfreq}", name: "${word}", color: "#E7823A" },
			{ y: rest, name: "나머지 검색어", color: "#546BC1" }
		]
	}],
	word: [{
		color: "#E7823A",
		name: word,
		type: "column",
		dataPoints: [
			{ x: new Date("${ar7}"), y: parseInt("${arr7}") },
			{ x: new Date("${ar6}"), y: parseInt("${arr6}") },
			{ x: new Date("${ar5}"), y: parseInt("${arr5}") },
			{ x: new Date("${ar4}"), y: parseInt("${arr4}") },
			{ x: new Date("${ar3}"), y: parseInt("${arr3}") },
			{ x: new Date("${ar2}"), y: parseInt("${arr2}") },
			{ x: new Date("${ar1}"), y: parseInt("${arr1}") },
			{ x: new Date("${ar0}"), y: parseInt("${arr0}") }
			
		]
	}],
	"나머지 검색어": [{
		color: "#546BC1",
		name: "나머지 검색어",
		type: "column",
		dataPoints: [
		  { x: new Date("${ar7}"), y: parseInt("${a7}") },
			{ x: new Date("${ar6}"), y: parseInt("${a6}") },
			{ x: new Date("${ar5}"), y: parseInt("${a5}") },
			{ x: new Date("${ar4}"), y: parseInt("${a4}") },
			{ x: new Date("${ar3}"), y: parseInt("${a3}") },
			{ x: new Date("${ar2}"), y: parseInt("${a2}") },
			{ x: new Date("${ar1}"), y: parseInt("${a1}") },
			{ x: new Date("${ar0}"), y: parseInt("${a0}") }
		]
	}]
};

var newVSReturningVisitorsOptions = {
	animationEnabled: true,
	theme: "light2",
	title: {
		text: "최근 7일 간 검색 횟수 동향"
	},
	subtitles: [{
		text: "Click on Any Segment to Drilldown",
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
	theme: "light2",
	axisX: {
		labelFontColor: "#717171",
		lineColor: "#a2a2a2",
		tickColor: "#a2a2a2",
		fontSize: 5,
		labelFontSize: 10
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
	chart.options.data = visitorsData[e.dataPoint.name];
	//
	chart.options.title = { text: e.dataPoint.name }
	chart.render();
	$("#backButton").toggleClass("invisible");
}

$("#backButton").click(function() { 
	$(this).toggleClass("invisible");
	chart = new CanvasJS.Chart("chartContainer", newVSReturningVisitorsOptions);
	chart.options.data = visitorsData["New vs Returning Visitors"];
	chart.render();
});

}
</script>  -->
<style>
  
</style>
<link href="../css/style.css" rel="Stylesheet" type="text/css">

</head>
<body>

<div id="chartContainer" data-allfreq='${allfreq}' data-rest='${rest}' data-maxfreq='${maxfreq}' data-word='${word}' 
                                    data-ar0='${ar0}' data-ar1='${ar1}' data-ar2='${ar2}' data-ar3='${ar3}' data-ar4='${ar4}' data-ar5='${ar5}' data-ar6='${ar6}' data-ar7='${ar7}'
                                    data-arr0='${arr0}' data-arr1='${arr1}' data-ar2='${arr2}' data-arr3='${arr3}' data-arr4='${arr4}' data-arr5='${arr5}' data-arr6='${arr6}' data-arr7='${arr7}'
                                    data-a0='${a0}' data-a1='${a1}' data-a2='${a2}' data-a3='${a3}' data-a4='${a4}' data-a5='${a5}' data-a6='${a6}' data-a7='${a7}' 
                      style="height: 370px; width: 527px;"></div>
<button class="btn invisible" id="backButton">< Back</button>
<script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script type="text/javascript" src="../js/wordtimegraph.js"></script> 
</body>
</html>