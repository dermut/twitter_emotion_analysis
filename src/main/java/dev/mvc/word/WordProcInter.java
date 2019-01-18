package dev.mvc.word;

import java.util.List;

public interface WordProcInter {

  /**
   * �˻��� ���
   * @param wordVO
   * @return
   */
  public int create(String word);
  
  /**
   * �˻��� ���� �� ����
   * @param word
   * @return
   */
  public int count_by_word(String word);
  
  /**
   * �� ����
   * @return
   */
  public int count();
  
  /**
   * �˻��� ����Ʈ
   * @return
   */
  public List<WordVO> word_list();
  
  /**
   * �˻���� �˻����ȣ �˾Ƴ���
   * @param word
   * @return
   */
  public int wordno_by_word(String word);
  
  public int search_word(String word);
}
