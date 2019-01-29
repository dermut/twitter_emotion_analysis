package dev.mvc.word_time_graph;

import java.util.List;
import java.util.Map;

public interface WordTimeGraphProcInter {

  /**
   * 검색어 동향 생성
   * @param wordTimeGraphVO
   * @return
   */
  public int create(WordTimeGraphVO wordTimeGraphVO);
  
  /**
   * 검색어 동향 단순 리스트(개발 편의용)
   * @return
   */
  public List<WordTimeGraphVO> list();
  
  /**
   * 일주일 단위의 매일의 검색 빈도
   * @param day
   * @return
   */
  public int freq_by_day(int day, int wordno);
  
  /**
   * 차트 그리기
   * @return
   */
  List<List<Map<Object, Object>>> getCanvasjsChartData();
  
  /**
   * 검색어들의 빈도의 총합
   * @return
   */
  public int allFreq();
  
  /**
   * 특정 검색어 빈도 최댓값
   * @param wordno
   * @return
   */
  public int maxFreq(int wordno);
  
  /**
   * 일주일 단위의 매일의 총 검색 빈도
   * @return
   */
  public int all_freq_by_day(int day);
}
