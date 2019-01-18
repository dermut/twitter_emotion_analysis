package dev.mvc.member_word;

import java.util.List;
import java.util.Map;

public interface Member_WordDAOInter {

  /**
   * ȸ�� �˻��� ���
   * @param memberno
   * @param wordno
   * @return
   */
  public int create(Map<String, Object> map);
  
  /**
   * ȸ�� �� �˻����ȣ ���
   * @param memberno
   * @return
   */
  public List<Word_MemberWordVO> wordno_by_member(int memberno);
  
  /**
   * Ư�� �˻�� � ȸ���� �˻��ߴ���
   * @param wordno
   * @return
   */
  public List<Word_MemberWordVO> member_by_wordno(int wordno);
}
