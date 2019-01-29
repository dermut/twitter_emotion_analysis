package dev.mvc.word_time_graph;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.word_time_graph.WordTimeGraphProc")
public class WordTimeGraphProc implements WordTimeGraphProcInter{

  @Autowired
  @Qualifier("dev.mvc.word_time_graph.WordTimeGraphDAO")
  private WordTimeGraphDAOInter wordTimeGraphDAO = null;
  
  public WordTimeGraphProc(){
    System.out.println("--> WordTimeGraphProc created.");
  }
  
  @Override
  public int create(WordTimeGraphVO wordTimeGraphVO) {
    int count = wordTimeGraphDAO.create(wordTimeGraphVO);
    return count;
  }

  @Override
  public List<WordTimeGraphVO> list() {
    List<WordTimeGraphVO> list = wordTimeGraphDAO.list();
    return list;
  }

  @Override
  public int freq_by_day(int day, int wordno) {
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("day", day);
    map.put("wordno", wordno);
    
    int num = wordTimeGraphDAO.freq_by_day(map);
    return num;
  }
  
  @Override
  public List<List<Map<Object, Object>>> getCanvasjsChartData() {
    return wordTimeGraphDAO.getCanvasjsChartData();
  }
 
  @Override
  public int allFreq() {
    int num = wordTimeGraphDAO.allFreq();
    return num; 
  }

  @Override
  public int maxFreq(int wordno) {
    int num = wordTimeGraphDAO.maxFreq(wordno);
    return num;
  }

  @Override
  public int all_freq_by_day(int day) {
    int num = wordTimeGraphDAO.all_freq_by_day(day);
    return num;
  } 

}
