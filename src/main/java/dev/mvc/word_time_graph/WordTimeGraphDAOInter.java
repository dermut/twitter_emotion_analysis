package dev.mvc.word_time_graph;

import java.util.List;
import java.util.Map;

public interface WordTimeGraphDAOInter {

  /**
   * �˻��� ���� ����
   * @param wordTimeGraphVO
   * @return
   */
  public int create(WordTimeGraphVO wordTimeGraphVO);
  
  /**
   * �˻��� ���� �ܼ� ����Ʈ(���� ���ǿ�)
   * @return
   */
  public List<WordTimeGraphVO> list();
  
  /**
   * ������ ������ ������ �˻��� �˻� ��
   * @param map
   * @return
   */
  public int freq_by_day(Map<String, Object> map);
  
  /**
   * ������ ������ ������ �� �˻� ��
   * @return
   */
  public int all_freq_by_day(int day);
  
  /**
   * ��Ʈ �׸���
   * @return
   */
  List<List<Map<Object, Object>>> getCanvasjsChartData();
  
  /**
   * �˻������ ���� ����
   * @return
   */
  public int allFreq();
  
  /**
   * Ư�� �˻��� �� �ִ�
   * @param wordno
   * @return
   */
  public int maxFreq(int wordno);
}
