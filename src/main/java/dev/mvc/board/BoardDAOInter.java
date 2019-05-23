package dev.mvc.board;

import java.util.List;

public interface BoardDAOInter {
  /**
   * ���
   * @param boardVO ����� ������
   * @return ó���� ���ڵ� ����
   */
  public abstract int create(BoardVO boardVO);
  
  /**
   * ���
   * @return Join ���
   */
  public List<Categrp_BoardVO> list();
  
  /**
   * ���
   * @return �޴��� ǥ�õǴ� ���
   */
  public List<BoardVO> list_menu();  
  
  /**
   * ���
   * @param categrpno ī�װ� �׷� ��ȣ
   * @return Join ���
   */
  public List<Categrp_BoardVO> list_by_categrp(int categrpno);
  
  /**
   * ���
   * @param categrpno ī�װ� �׷� ��ȣ
   * @return Join ���
   */
  public List<Categrp_BoardVO> list_by_categrp_id(int categrpno);

  /**
   * �Ѱ��� ���ڵ� ��ȸ
   * @param categrpno
   * @return
   */
  public BoardVO read(int boardno);
  
  /**
   * ���ڵ带 �����մϴ�.
   * @param boardVO 
   * @return
   */
  public int update(BoardVO boardVO);
  
  /**
   * �Ѱ��� ���ڵ� ����
   * @param boardno
   * @return
   */
  public int delete(int boardno);
  
  public int delete_by_categrp(int categrpno);
  
  public int count_by_board(int boardno);

  public int delete_contents_by_board(int boardno);
  
  public String getId(int memberno);
}









