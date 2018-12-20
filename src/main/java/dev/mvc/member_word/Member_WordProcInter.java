package dev.mvc.member_word;

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
  public Member_WordVO wordno_by_member(int memberno);
  
  /**
   * Ư�� �˻�� � ȸ���� �˻��ߴ���
   * @param wordno
   * @return
   */
  public Member_WordVO member_by_wordno(int wordno);
}
