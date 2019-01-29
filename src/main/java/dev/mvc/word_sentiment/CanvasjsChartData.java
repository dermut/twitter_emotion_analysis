package dev.mvc.word_sentiment;
 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
 
public class CanvasjsChartData {
  
  public static int y1;
  public static int y2;
  public static int y3;
  public static int y4;
  public static int y5;
  public static int y6;
  public static int y7;
  public static int y8;
  public static int allfreq;
  public static int maxfreq;
  
  public static int getY1() {
    return y1;
  }
  public static void setY1(int y1) {
    CanvasjsChartData.y1 = y1;
  }
  public static int getY2() {
    return y2;
  }
  public static void setY2(int y2) {
    CanvasjsChartData.y2 = y2;
  }
  public static int getY3() {
    return y3;
  }
  public static void setY3(int y3) {
    CanvasjsChartData.y3 = y3;
  }
  public static int getY4() {
    return y4;
  }
  public static void setY4(int y4) {
    CanvasjsChartData.y4 = y4;
  }
  public static int getY5() {
    return y5;
  }
  public static void setY5(int y5) {
    CanvasjsChartData.y5 = y5;
  }
  public static int getY6() {
    return y6;
  }
  public static void setY6(int y6) {
    CanvasjsChartData.y6 = y6;
  }
  public static int getY7() {
    return y7;
  }
  public static void setY7(int y7) {
    CanvasjsChartData.y7 = y7;
  }
  public static int getY8() {
    return y8;
  }
  public static void setY8(int y8) {
    CanvasjsChartData.y8 = y8;
  }
  public static int getAllfreq() {
    return allfreq;
  }
  public static void setAllfreq(int allfreq) {
    CanvasjsChartData.allfreq = allfreq;
  }
  public static int getMaxfreq() {
    return maxfreq;
  }
  public static void setMaxfreq(int maxfreq) {
    CanvasjsChartData.maxfreq = maxfreq;
  }
  static Map<Object,Object> map = null;
	static List<List<Map<Object,Object>>> list = new ArrayList<List<Map<Object,Object>>>();
	static List<Map<Object,Object>> dataPoints1 = new ArrayList<Map<Object,Object>>();
	static List<Map<Object,Object>> dataPoints2 = new ArrayList<Map<Object,Object>>();
	static List<Map<Object,Object>> dataPoints3 = new ArrayList<Map<Object,Object>>();
	// 값 고정 
	//static{
	public static void setCanvasjsDataList() { 
		// 차트의 이름(name), y값(총 freq), 색깔은 추후 지정
		map = new HashMap<Object,Object>(); map.put("name", "검색한 검색어"); map.put("y", maxfreq); map.put("color", "#E7823A");	dataPoints1.add(map);
		map = new HashMap<Object,Object>(); map.put("name", "나머지 검색어"); map.put("y", allfreq-maxfreq); map.put("color", "#546BC1"); 	dataPoints1.add(map);  
		
		// y값들 8개를 넣어주어야 함(7일 전 값부터 순서대로 오늘까지 넣는다)
		map = new HashMap<Object,Object>(); map.put("x", 2); map.put("y", y8);dataPoints2.add(map);
		map = new HashMap<Object,Object>(); map.put("x", 4); map.put("y", y7);dataPoints2.add(map);
		map = new HashMap<Object,Object>(); map.put("x", 6); map.put("y", y6);dataPoints2.add(map);
		map = new HashMap<Object,Object>(); map.put("x", 8); map.put("y", y5);dataPoints2.add(map);
		map = new HashMap<Object,Object>(); map.put("x", 10); map.put("y", y4);dataPoints2.add(map);
		map = new HashMap<Object,Object>(); map.put("x", 12); map.put("y", y3);dataPoints2.add(map);
		map = new HashMap<Object,Object>(); map.put("x", 14); map.put("y", y2);dataPoints2.add(map);
		map = new HashMap<Object,Object>(); map.put("x", 16); map.put("y", y1);dataPoints2.add(map);			
		
		map = new HashMap<Object,Object>(); map.put("x", 2); map.put("y", 10);dataPoints3.add(map);
    map = new HashMap<Object,Object>(); map.put("x", 4); map.put("y", 4);dataPoints3.add(map);
    map = new HashMap<Object,Object>(); map.put("x", 6); map.put("y", 8);dataPoints3.add(map);
    map = new HashMap<Object,Object>(); map.put("x", 8); map.put("y", 2);dataPoints3.add(map);
    map = new HashMap<Object,Object>(); map.put("x", 10); map.put("y", 12);dataPoints3.add(map);
    map = new HashMap<Object,Object>(); map.put("x", 12); map.put("y", 6);dataPoints3.add(map);
    map = new HashMap<Object,Object>(); map.put("x", 14); map.put("y", 0);dataPoints3.add(map);
    map = new HashMap<Object,Object>(); map.put("x", 16); map.put("y", 6);dataPoints3.add(map);

		list.add(dataPoints1);
		list.add(dataPoints2);
		list.add(dataPoints3);
	}
 	// setter 만들기 ?
	public static List<List<Map<Object, Object>>> getCanvasjsDataList() {
	  
		return list;
	}
}      