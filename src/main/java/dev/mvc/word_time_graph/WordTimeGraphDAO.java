package dev.mvc.word_time_graph;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dev.mvc.word_sentiment.CanvasjsChartData;

@Repository("dev.mvc.word_time_graph.WordTimeGraphDAO")
public class WordTimeGraphDAO implements WordTimeGraphDAOInter{

  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public WordTimeGraphDAO() {
    System.out.println("--> WordTimeGraphDAO created.");
  }
  
  @Override
  public int create(WordTimeGraphVO wordTimeGraphVO) {
    int count = sqlSessionTemplate.insert("wordTimeGraph.create", wordTimeGraphVO);
    return count;
  }

  @Override
  public List<WordTimeGraphVO> list() {
    List<WordTimeGraphVO> list = sqlSessionTemplate.selectList("wordTimeGraph.list");
    return list;
  }

  @Override
  public int freq_by_day(Map<String, Object> map) {
    int num = sqlSessionTemplate.selectOne("wordTimeGraph.freq_by_day", map);
    return num; 
  }
  
  @Override
  public List<List<Map<Object, Object>>> getCanvasjsChartData() {
    return CanvasjsChartData.getCanvasjsDataList();
  }

  @Override
  public int allFreq() {
    int num = sqlSessionTemplate.selectOne("wordTimeGraph.allFreq");
    return num;
  }

  @Override
  public int maxFreq(int wordno) {
    int num = sqlSessionTemplate.selectOne("wordTimeGraph.maxFreq", wordno);
    return num;
  }

  @Override
  public int all_freq_by_day(int day) {
    int num = sqlSessionTemplate.selectOne("wordTimeGraph.all_freq_by_day", day);
    return num;
  }

  
  
}
