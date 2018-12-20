package dev.mvc.word;

import java.util.List;

public interface WordDAOInter {

  /**
   * 검색어 등록
   * @param wordVO
   * @return
   */
  public int create(String word);
  
  /**
   * 검색어 별 총 갯수
   * @param word
   * @return
   */
  public int count_by_word(String word);
  
  /**
   * 총 갯수
   * @return
   */
  public int count();
  
  /**
   * 검색어 리스트
   * @return
   */
  public List<WordVO> word_list();
  
  /**
   * 검색어로 검색어번호 알아내기
   * @param word
   * @return
   */
  public int wordno_by_word(String word);
}
