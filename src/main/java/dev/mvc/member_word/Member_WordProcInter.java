package dev.mvc.member_word;

import java.util.List;

public interface Member_WordProcInter {

  /**
   * ȸ�� �˻��� ���
   * @param memberno
   * @param wordno
   * @return
   */
  public int create(int memberno, int wordno);
  
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
